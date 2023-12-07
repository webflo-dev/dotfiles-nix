{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;

  # xdg.dataFile."fonts".source = ./src;

  xdg.dataFile."fonts/Luciole".source = ./src/Luciole;
  xdg.dataFile."fonts/Martian-Mono-1.0.0".source = ./src/Martian-Mono-1.0.0;
  xdg.dataFile."fonts/smoke-test.sh".source = ./src/smoke-test.sh;

}
