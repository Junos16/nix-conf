{ pkgs, codexPackage, ... }:

{
  imports = [
    ./sway.nix
  ];

  home.username = "hriddhit";
  home.homeDirectory = "/home/hriddhit";

  home.packages = (with pkgs; [
    tmux
    fastfetch
    fzf
    ripgrep
    jq
    yazi
    btop
    
    qpdfview
    imv
    mpv
    krita
    rnote

    spotify
    discord
    zoom
    stremio-linux-shell
  ]) ++ ([
    codexPackage
  ]);

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

  programs.zathura.enable = true;
  programs.firefox.enable = true;

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
  };

  home.stateVersion = "26.05";
}
