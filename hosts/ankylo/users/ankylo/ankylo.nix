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
      hashedPassword = "$6$mprx9SewLPF8HEvc$kQBbrWAfb1P7udGY3rNQdtY9eU/EVr95P6lIJiDgh9YGOeihCqWKAlGvAEr.cUwNyQml4UHIqPeTro4rZHfZy/";
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
}
