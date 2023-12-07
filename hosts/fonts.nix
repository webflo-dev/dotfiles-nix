{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      noto-fonts-color-emoji
      fira-code
      monaspace
      (nerdfonts.override {
        fonts = [ "NerdFontsSymbolsOnly" ];
      })
    ];
    fontconfig = {
      enable = true;
      hinting = {
        enable = true;
        autohint = false;
        style = "slight";
      };
      subpixel = {
        rgba = "rgb";
	lcdfilter = "default";
      };

      defaultFonts = {
        # serif = [ "Luciole" ];
        # sansSerif = [ "Luciole" ];
        # monospace = [ "Cartograph CF" ];
        serif = [ "Luciole" "Noto Color Emoji" "Symbols Nerd Font" ];
        sansSerif = [ "Luciole" "Noto Color Emoji" "Symbols Nerd Font" ];
        monospace = [ "Fira Code" "Noto Color Emoji" "Symbols Nerd Font" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

}
