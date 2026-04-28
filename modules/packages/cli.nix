{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    diffutils
    gnumake
    just
    zoxide
    fzf
    fd
    bat
    ripgrep
    gcc
    unzip
    wget
    btop
    fastfetch
    yazi
    jq
    yq
  ];
}
