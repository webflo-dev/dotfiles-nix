{ pkgs, inputs, ... }:

{
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };


  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    grim
    slurp
    swaybg
    swaylock
    swappy
    wf-recorder
    wl-clipboard
    wlr-randr

    gnome.gnome-keyring
    polkit_gnome

    # hyprland related
    # xdg-desktop-portal-hyprland
    # xdg-desktop-portal-gtk

    # gnome.adwaita-icon-theme
    # gnome.gnome-themes-extra
    # qt5.qtwayland
    # qt6.qtwayland
    # adwaita-qt
    # adwaita-qt6
  ];

  environment.sessionVariables = {
    # POLKIT_AUTH_AGENT = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    # GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas";

    CLUTTER_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    SDL_VIDEODRIVER = "wayland";

    QT_QPA_PLATFORM = "wayland-egl"; #error with apps xcb
    QT_WAYLAND_FORCE_DPI = "physical";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";

    GTK_USE_PORTAL = "1";
    NIXOS_XDG_OPEN_USE_PORTAL = "1";
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
