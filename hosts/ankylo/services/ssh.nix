{ ... }:
{

  users.users.server = {
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCm605AM/8OO6FzPba8Px72eO48tzwWZNzJ7LHhZq+dxanPp6IA+CsiSMebImnr4V7+QF5zQFq3qvfysHFNeCZ+qgFDNYn1kFnO/jJ1Wwj4UIjConJacYsF9wDpKjaY3QHsUHsfg3Yko/Sa9f/Q37U5By4yrfrx5/qHa207HoufKxCcgmGVHtPPXbVsLy8OKcoScS09OsOLsX6voUhh9ZLA1HOHjAHML5Ltac8oFQzenyEdXOVSehLrXiY+C1WMFUi9i/zzwA4BaVGL3j9UBzeg5tG/To2zxjrO5lrmRG/4wLcAovDMWIAiTYXCLHsoNPrEmicHsMgtl1+zHUqRaQmj warden_digital@nixos"
    ];
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };
}
