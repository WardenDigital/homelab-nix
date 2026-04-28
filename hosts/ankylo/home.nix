{ pkgs, ... }:
{
  home.stateVersion = "25.11";
  home.username = "warden_digital";
  home.homeDirectory = "/home/warden_digital";

  imports = [
    ./../../modules/home/wm/hyprland.nix
    ./home/cli.nix
    ./home/terminal.nix
  ];

  home.packages = with pkgs; [
    imagemagick
    ghostscript
    tectonic
    vscode
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "WardenDigital";
        email = "wardendigital@proton.me";
      };
      pull = {
        rebase = false;
      };
      core = {
        editor = "nvim";
      };
    };
  };
}
