{ pkgs, ... }:

{
  home.username = "hriddhit";
  home.homeDirectory = "/home/hriddhit";

  home.packages = with pkgs; [
    tmux
    fastfetch
    fzf
    ripgrep
    jq
  ];

  home.stateVersion = "26.05";
}
