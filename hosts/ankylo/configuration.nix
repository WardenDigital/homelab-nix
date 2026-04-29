# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ pkgs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./disko-configuration.nix
    ./hardware-configuration.nix
    ./users/ankylo/ankylo.nix
    # Different configurations
    ./../../modules/packages/common.nix
    ./configurations/locale.nix
    ./configurations/laptop.nix
  ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking = {
    hostName = "ankylo";
    networkmanager = {
      enable = true;
    };
  };

  environment.shells = with pkgs; [
    bash
    nushell
  ];

  hardware = {
    graphics.enable = true;
    nvidia = {
      modesetting.enable = true;
    };
  };

  nix.settings = {
    experimental-features = "nix-command flakes";
    trusted-users = [
      "root"
      "ankylo"
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.nix-ld.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  security.rtkit.enable = true;
  services = {
    dbus.enable = true;
  };

  console.keyMap = "us";

  xdg.portal.enable = false;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "25.11";
}
