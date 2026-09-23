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

  home.file.".local/bin/iitk-net" = {
    source = ../../iitk-net;
    executable = true;
  };

  systemd.user.services.iitk-net = {
    Unit = {
      Description = "IITK Fortinet Internet Keepalive";
    };

    Service = {
      Type = "simple";
      ExecStart = "%h/.local/bin/iitk-net";
      Restart = "always";
      RestartSec = 5;
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };


  home.stateVersion = "26.05";
}
