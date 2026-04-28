{ pkgs, ... }:
{
  imports = [
    (import ./../../../../common/dev/tools/docker.nix { active_user = "ankylo"; })
    ../../services/services.nix
  ];

  environment.systemPackages = with pkgs; [
    starship
  ];

  users.defaultUserShell = pkgs.nushell;

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
  ];
}
