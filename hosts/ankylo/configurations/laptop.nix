{ ... }:
{

  services.logind.extraConfig = ''
    # Don't suspend when the lid is closed
    HandleLidSwitch=ignore
    HandleLidSwitchExternalPower=ignore
    HandleLidSwitchDocked=ignore
  '';
  # Blackout screen after 60 seconds
  boot.kernelParams = [ "consoleblank=60" ];
  # Termal control daemon
  services.thermald.enable = true;
}
