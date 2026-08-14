{ pkgs, ... }:
{
  imports = [
    (import ./../../../../common/dev/tools/docker.nix { active_user = "ankylo"; })
    ../../services/services.nix
  ];

  environment.systemPackages = [ ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.bash;
    users.ankylo = {
      isNormalUser = true;
      hashedPassword = "$y$j9T$lZiGeTGKoEyyaw17kE1w9.$ZHu0XTYWgQ79vE8hfgQxIEs8/VE/4w0qRa4cFuAW24/";
      description = "main server user";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };
  };
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
  ];

  systemd.tmpfiles.rules = [
    "d /data 0755 ankylo users -"
  ];
}
