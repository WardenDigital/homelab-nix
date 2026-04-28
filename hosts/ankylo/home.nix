{ ... }:
{
  home.stateVersion = "25.11";
  home.username = "ankylo";
  home.homeDirectory = "/home/ankylo";

  imports = [
    ./home/cli.nix
    ./home/terminal.nix
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "homelab-ankylo";
        email = "homelab+wardendigital@proton.me";
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
