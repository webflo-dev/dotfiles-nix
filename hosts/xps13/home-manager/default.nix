{ pkgs, home, inputs, ... }:
let
  username = "florent";
in
{
  imports = [
    ./ags
    ./fonts
    ./git
    ./gtk
    ./hyprland
    ./kitty
    ./neofetch
    ./pulsemixer
    ./wezterm
  ];

  programs.home-manager.enable = true;

  home = {
    stateVersion = "23.11";
    username = username;
    homeDirectory = "/home/${username}";
    packages = with pkgs; [
      # CLI
      croc
      inotify-tools
      lnav
      zsh

      ### GUI
      font-manager
      vscode
      microsoft-edge
      spotify

      ### Security
      polkit_gnome
      gnome.gnome-keyring
    ];
  };

  programs.bat.enable = true;
  programs.gitui.enable = true;
  programs.imv.enable = true;
  programs.sniffnet.enable = true;

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };


  services.gnome.gnome-keyring.enable = true;



  xdg.configFile."nvim".source = ./nvim;

  xdg.configFile."zsh".source = ./zsh;

  home.file."${home.homeDirectory}/.local/bin".source = ./local-bin;

}

