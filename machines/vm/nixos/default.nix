{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/configuration.nix
      ./locale.nix
      ./pipewire.nix
    ];


  # boot = {
  #   loader = {
  #     timeout = 2;
  #     systemd-boot.enable = true;
  #     efi.canTouchEfiVariables = true;
  #   };
  #   tmp.cleanOnBoot = true;
  # };

  networking = {
    networkmanager.enable = true;
    # wireless.enable = true;
  };

  # Allow unfree packages
  # nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.allowUnfreePredicate = pkg:
  #   builtins.elem (lib.getName pkg) [
  #     "#nvidia-x11"
  #   ];


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


  # Enable CUPS to print documents.
  services.printing.enable = true;

  boot.kernel.sysctl."fs.inotify.max_user_instances" = 524288;
  boot.kernel.sysctl."fs.inotify.max_user_watches" = 524288;


  environment.systemPackages = with pkgs; [
    home-manager
    neovim
    git
    curl
  ];


  system.stateVersion = "23.05";
}
