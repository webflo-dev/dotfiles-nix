{ pkgs, ... }:
let
  username = "florent";
in
{
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      storage-driver = "overlay2";
      features = { buildkit = true; };
      experimental = true;
      no-new-privileges = true;
    };
    autoPrune = {
      enable = true;
      flags = [ "--all" ];
      dates = "weekly";
    };
  };

  users.groups.docker.members = [ "${username}" ];

  environment.systemPackages = with pkgs; [
    docker
    docker-compose
  ];
}
