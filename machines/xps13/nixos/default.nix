{ config, pkgs, nixos-hardware, ...}:

{
  imports = [
     nixos-hardware.nixosModules.dell-xps-13-9300
    ./hardware-configuration.nix
  ]

  system.stateVersion = "23.05";

  boot = {
    tmp.cleanOnBoot = true;
    loader = {
      timeout = 2;
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
    };
    kernel = {
      sysctl."fs.inotify.max_user_instances" = 524288;
      sysctl."fs.inotify.max_user_watches" = 524288;
    };
  };

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
    hostName = "xps13";
    useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
  }

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

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-generation +20";
      # options = "--delete-older-than 7";
    };
  };

  time.timeZone = "Europe/Paris";
  console.keyMap = "fr";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "fr_FR.UTF-8";
      LC_IDENTIFICATION = "fr_FR.UTF-8";
      LC_MEASUREMENT = "fr_FR.UTF-8";
      LC_MONETARY = "fr_FR.UTF-8";
      LC_NAME = "fr_FR.UTF-8";
      LC_NUMERIC = "fr_FR.UTF-8";
      LC_PAPER = "fr_FR.UTF-8";
      LC_TELEPHONE = "fr_FR.UTF-8";
      LC_TIME = "fr_FR.UTF-8";
    };
  };

  # Print support
  services.printing.enable = true;

  # Touchpad support
  services.xserver.libinput.enable = true;

  # Bluetooth support
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}