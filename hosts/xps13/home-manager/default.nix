{ pkgs, inputs, ... }:
let
  username = "florent";
in
{
  imports = [
    ./hyprland.nix
    ./ags.nix
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
      neofetch
      starship
      wezterm
      zsh


      ### GUI
      font-manager
      kitty
      vscode
      microsoft-edge
      sniffnet
      spotify
      xfce.thunar
      xfce.thunar-archive-plugin
      xfce.thunar-volman
    ];
  };

  xdg.configFile."git".source = ./git;
  xdg.configFile."kitty".source = ./kitty;
  xdg.configFile."neofetch".source = ./neofetch;
  xdg.configFile."nvim".source = ./nvim;
  xdg.configFile."wezterm".source = ./wezterm;
  xdg.configFile."zsh".source = ./zsh;

  home.file."${home.homeDirectory}/.local/bin".source = ./local-bin;

}

