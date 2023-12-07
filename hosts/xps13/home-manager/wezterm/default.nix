{ pkgs, ... }:
{
  home.packages = [
    pkgs.wezterm
  ];

  xdg.configFile."wezterm".source = ./src;

}
