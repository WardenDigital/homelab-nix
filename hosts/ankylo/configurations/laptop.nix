{ ... }:
{
  # Blackout screen after 60 seconds
  boot.kernelParams = [ "consoleblank=60" ];
  # Termal control daemon
  services = {
    logind.settings.Login = {
      HandleLidSwitchExternalPower = "ignore";
      HandleLidSwitchDocked = "ignore";
      HandleLidSwitch = "ignore";
    };

    tlp = {
      enable = true;
      settings = {
        # Stop charging at 80%, start again when it drops to 75%
        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };
    thermald.enable = true;
  };
}
