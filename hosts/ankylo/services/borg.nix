{ ... }:
{
  services.borgbackup.jobs.warden_digital = {
    paths = [
      "/home/action-runner/mysq-prod-data"
      "/home/action-runner/storage"
    ];
    # switch key to sops
    sshKey = "/root/.ssh/id_ed25519";
    encryption = {
      mode = "repokey-blake2";
      # switch to sops
      passphraseFile = "/etc/borg/passphrase";
    };
    # switch to sops
    remotePath = "action-runner@<ip>";
    repo = "/data/backups/warden.digital";
    compression = "auto,zstd";
    startAt = "daily";
  };
}
