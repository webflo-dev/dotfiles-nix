{ pkgs, inputs, ... }:
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
    ./mime-apps
    ./neofetch
    ./pulsemixer
    ./ranger
    ./wezterm
    ./xdg
    ./zsh
  ];

  programs.home-manager.enable = true;

  home = {
    stateVersion = "23.11";
    username = username;
    homeDirectory = "/home/${username}";
    packages = with pkgs; [
      # CLI
      bat
      croc
      gitui
      imv
      inotify-tools
      lnav
      sniffnet

      ### GUI
      font-manager
      microsoft-edge
      spotify
      vscode

      ### Security
      gnome.gnome-keyring
      polkit_gnome
    ];
  };

  # xdg.configFile."nvim".source = ./nvim;

  home.file.".local/bin".source = ./local-bin;
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

}

