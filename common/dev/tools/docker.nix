{ active_user, ... }: { pkgs, config, ... }:

{
    virtualisation.docker.enable = true;
    virtualisation.podman.enable = true;


    environment.systemPackages = with pkgs; [
      docker-compose
      distrobox
    ];

    users.users.${active_user}.extraGroups = ["docker"];
}
