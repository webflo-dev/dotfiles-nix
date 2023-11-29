{ pkgs, inputs, ...}:
{
   imports = [
      inputs.ags.homeManagerModules.default
   ];

   home.packages = with pkgs; [
      sassc
   ];

   programs.ags = {
      enable = true;
      configDir = ./ags;
   };
}
