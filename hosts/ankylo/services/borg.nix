# Pull-based backups.
#
# The homelab is never exposed to the world: this machine only makes
# OUTBOUND connections to the sources below, pulls MySQL dumps + file
# paths into a staging dir, then archives them into a local borg repo.
#
# One-time setup per source server:
#   - the ssh key used for pulling is `sshKey` below — currently the homelab
#     host key (/etc/ssh/ssh_host_ed25519_key); put its .pub on the remote
#     user's authorized_keys as a SCOPED entry, e.g.:
#       restrict,from="<homelab-ip>",command="/home/<user>/.ssh/backup-wrapper" ssh-ed25519 <pubkey> homelab-backup
#     (wrapper script + syntax: see "Scoped keys on source servers" in AGENTS.md.
#     It whitelists exactly the remote commands generated below.)
#   - create a MySQL dump user on the server and give its creds to the ssh user
#     via ~/.my.cnf (chmod 600):  [client] user=borgbackup / password=...
#       CREATE USER 'borgbackup'@'%' IDENTIFIED BY '<password>';
#       GRANT SELECT, RELOAD, LOCK TABLES, PROCESS, SHOW VIEW, EVENT, TRIGGER
#         ON *.* TO 'borgbackup'@'%';
#   - add the sops secret borg-passphrase to homelab-secrets/secrets/secrets.yaml
#     (required, else activation fails)
#   - for paths in the `sqlite` list: `sqlite3` CLI must be installed on the
#     source server (used for online `.backup` snapshots of live DBs)
#   - `rsync` must be installed on the source server (pulls file paths and
#     the sqlite snapshots)
{ pkgs, lib, ... }:
let
  stagingRoot = "/var/backups/pull";
  sshKey = "/etc/ssh/ssh_host_ed25519_key";
  sshBase = "${pkgs.openssh}/bin/ssh -i ${sshKey} -o BatchMode=yes -o StrictHostKeyChecking=accept-new";

  # Servers to pull from. Add future machines here.
  sources = [
    {
      name = "warden.digital";
      user = "devops";
      host = "2.56.99.131"; # TODO: actual host
      dbs = [ "production-cv-database" ]; # TODO: actual database names (one .sql.gz per db)
      sqlite = [ ]; # TODO: paths to .db/.sqlite files (snapshot via sqlite3 .backup)
      paths = [ "/home/action-runner/storage" ];
    }
    {
      name = "interval";
      user = "interval";
      host = "2.56.99.131"; # TODO: actual host
      dbs = [ ]; # TODO: actual database names (one .sql.gz per db)
      # Each path is snapshotted ON the server (sqlite3 .backup -> /tmp/<name>.borg-bak),
      # pulled back via rsync, temp removed afterwards. WAL-safe on live DBs.
      # Needs: sqlite3 CLI on the server + read access for user "interval"; no spaces in path.
      # NOTE: a path that doesn't exist on the server FAILS the whole job (set -euo pipefail).
      sqlite = [
        "/home/interval/storage/interval_admin/data/interval_admin.db"
      ];
      paths = [ "/home/interval/storage/interval_admin/storage" ];
    }

  ];

  mkSourcePull =
    s:
    let
      target = "${s.user}@${s.host}";
      dumps = lib.concatMapStringsSep "\n" (db: ''
        ${sshBase} ${target} "mysqldump --single-transaction --routines --triggers --databases ${db}" | ${pkgs.gzip}/bin/gzip -9 > ${stagingRoot}/${s.name}/${db}.sql.gz
      '') s.dbs;
      sqliteBackups = lib.concatMapStringsSep "\n" (
        p:
        let
          b = builtins.baseNameOf p;
        in
        ''
          ${sshBase} ${target} "rm -f /tmp/${b}.borg-bak"
          ${sshBase} ${target} "sqlite3 ${p} '.backup /tmp/${b}.borg-bak'"
          ${pkgs.rsync}/bin/rsync -az -e "${sshBase}" ${target}:/tmp/${b}.borg-bak ${stagingRoot}/${s.name}/${b}
          ${sshBase} ${target} "rm -f /tmp/${b}.borg-bak"
        ''
      ) s.sqlite;
      fileSyncs = lib.concatMapStringsSep "\n" (p: ''
        ${pkgs.rsync}/bin/rsync -az --delete -e "${sshBase}" ${target}:${p} ${stagingRoot}/${s.name}/
      '') s.paths;
    in
    ''
      ${pkgs.coreutils}/bin/mkdir -p ${stagingRoot}/${s.name}
      ${dumps}
      ${sqliteBackups}
      ${fileSyncs}
    '';

  pullScript = pkgs.writeScript "borg-pull" ''
    #!/bin/sh
    set -euo pipefail
    # ProtectSystem=strict: removing the staging dir itself would modify its
    # read-only parent (/var/backups); clear contents instead, keep the dir
    ${pkgs.findutils}/bin/find ${stagingRoot} -mindepth 1 -delete
    ${pkgs.coreutils}/bin/mkdir -p ${stagingRoot}
    ${lib.concatMapStringsSep "\n" mkSourcePull sources}
  '';
in
{
  systemd.tmpfiles.rules = [
    "d ${stagingRoot} 0700 root root -"
  ];

  sops.secrets = {
    "borg-passphrase" = {
      mode = "0400";
    };
  };

  services.borgbackup.jobs.warden_digital = {
    repo = "/data/backups/borg/warden_digital";
    paths = [ stagingRoot ];
    doInit = true;
    encryption = {
      mode = "repokey-blake2";
      # BORG_PASSCOMMAND is run by borg itself to obtain the passphrase;
      # keeps the secret out of the Nix store (passphrase= would leak it)
      passCommand = "${pkgs.coreutils}/bin/cat /run/secrets/borg-passphrase";
    };
    compression = "auto,zstd";
    startAt = "daily";
    # preHook writes dumps here; ProtectSystem=strict needs it explicit
    readWritePaths = [ stagingRoot ];
    preHook = "${pullScript}";
    postHook = "${pkgs.findutils}/bin/find ${stagingRoot} -mindepth 1 -delete";
    prune = {
      keep = {
        daily = 7;
        weekly = 4;
        monthly = 6;
        yearly = 1;
      };
    };
  };
}
