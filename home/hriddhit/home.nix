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

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Hriddhit Datta";
        email = "hriddhitdatta2002@gmail.com";
      };

      init.defaultBranch = "main";
    };
  };

  home.stateVersion = "26.05";
}
