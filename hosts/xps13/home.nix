{ pkgs, username, hostname ... }: {
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.packages = with pkgs; [
    ranger
    pulsemixer 
    neofetch
  ];

  programs.zsh.enable = true;
  programs.fzf.enable = true;
  programs.direnv.enable = true;
    
}
