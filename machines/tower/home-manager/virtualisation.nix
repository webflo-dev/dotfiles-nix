{ username, ... }:

{
  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
      autoPrune = {
        enable = true;
        flags = [ "--all" ];
        dates = "weekly";
      };
    };
    # docker.rootless = {
    #   enable = true;
    #   setSocketVariable = true;
    # };
    # podman.enable = true;
    libvirtd.enable = true;
  };

  users.users.${username} = {
    extraGroups = [ "libvirtd" ];
  };

}

