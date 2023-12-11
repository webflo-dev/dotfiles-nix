{ pkgs, ... }:
{
  services.printing = {
    enable = true;
    cups-pdf.enable = true;
    drivers = with pkgs; [
      gutenprint
      canon-cups-ufr2
    ];
  };

}
