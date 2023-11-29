{ nixos-hardware, ... }@inputs:
let
  hardware = nixos-hardware.nixosModules;
in
{
  tower = {
    system = "x86_64-linux";
    username = "florent";
  };

  vm = {
    system = "x86_64-linux";
    username = "vm";
  };

  xps13 = {
    system = "x86_64-linux";
    username = "florent";
    extraModules = [
      hardware.dell-xps-13-9300
    ];
  };
}

