{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    glibc
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
