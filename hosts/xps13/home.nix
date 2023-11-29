{ pkgs, username, ... }: {
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

  programs.zsh.enable = true;
  programs.fzf.enable = true;

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.packages = with pkgs; [
    ranger
    eza
  ];
}
