{ config, homelab-secrets, ... }:
{
  sops = {
    # This is the encrypted file you created with the sops CLI
    defaultSopsFile = "${homelab-secrets}/secrets/secrets.yaml";

    # Automatically import host SSH keys as age keys
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    secrets = {
      "key" = {
        # Optional: Define owner/group for the secret file
        owner = config.users.users.ankylo.name;
      };
    };
  };
}
