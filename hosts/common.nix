{ config, lib, nixpkgs, pkgs, inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default
    ./locales.nix
  ];


  boot = {
    tmp.cleanOnBoot = true;
    loader = {
      timeout = 2;
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
    kernel = {
      sysctl."fs.inotify.max_user_instances" = 524288;
      sysctl."fs.inotify.max_user_watches" = 524288;
    };
  };

  nixpkgs.config.allowUnfree = true;


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


  environment.systemPackages = with pkgs; [
    btop
    curl
    eza
    fd
    fzf
    gdu
    git
    home-manager
    neovim
    ranger
    ripgrep
    unzip
  ];
}
