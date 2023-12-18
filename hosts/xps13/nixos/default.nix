{ config, pkgs, nixos-hardware, ... }:
let
  hostname = "xps13";
  username = "florent";
in
{
  system.stateVersion = "23.11";

  imports = [
    ./hardware-configuration.nix
    ./bluetooth.nix
    ./fingerprint.nix
    ./hyprland.nix
    ./pipewire.nix
    ./docker.nix
    # ./print.nix
    ./work.nix
  ];

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback # screen sharing
  ];

  security = {
    tpm2 = {
      enable = true;
      pkcs11.enable = true;
    };
    rtkit.enable = true;
    polkit.enable = true;
    sudo.wheelNeedsPassword = true;
    sudo.execWheelOnly = true;
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


  environment.systemPackages = with pkgs; [
    inotify-tools
    networkmanagerapplet
    udiskie
  ];


  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "input"
      "audio"
      "video"
    ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;


  # Touchpad support
  services.xserver.libinput.enable = true;


  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
  services.gvfs.enable = true;

  services.gnome.gnome-keyring.enable = true;
}
