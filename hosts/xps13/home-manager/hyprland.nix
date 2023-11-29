{ pkgs, inputs, ... }:

{
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];


  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
  };

  xdg.configFile."hypr".source = ./hyprland;

  home.packages = with pkgs; [
    grim
    slurp
    swaybg
    swaylock
    swappy
    wf-recorder
    wl-clipboard
    wlr-randr

    papirus-icon-theme
  ];

}
