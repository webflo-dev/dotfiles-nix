{ config, pkgs, nixos-hardware, ... }:
let
  hostname = "xps13";
  username = "florent";
in
{
  system.stateVersion = "23.11";

  imports = [
    ./hardware-configuration.nix
    ./hyprland.nix
    ./pipewire.nix
  ];


  security = {
    tpm2 = {
      enable = true;
      pkcs11.enable = true;
    };
    rtkit.enable = true;
    polkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };

  hardware = {
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
      driSupport = true;
      driSupport32Bit = true;
    };
  };


  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "input" "audio" "video" ];
  };


  environment.systemPackages = with pkgs; [
    inotify-tools
  ];


  # Print support
  services.printing.enable = true;

  # Touchpad support
  services.xserver.libinput.enable = true;

  # Bluetooth support
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;



}
