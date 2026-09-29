{ homelab-secrets, ... }:
{
  sops = {
    # This is the encrypted file you created with the sops CLI
    defaultSopsFile = "${homelab-secrets}/secrets/secrets.yaml";

    # Automatically import host SSH keys as age keys
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    secrets = {
      "borg-passphrase" = {
      };
      "borg-warden-digital-maridb-pass" = {
      };

    };
  };
}
