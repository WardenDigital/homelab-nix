{ ... }:
{
  services.logind.settings.Login = {
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
    HandleLidSwitch = "ignore";
  };

  # Blackout screen after 60 seconds
  boot.kernelParams = [ "consoleblank=60" ];
  # Termal control daemon
  services.thermald.enable = true;
}
