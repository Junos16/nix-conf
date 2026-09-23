{ ... }:

{  
  home.file.".local/bin/iitk-net" = {
    source = ../../iitk-net;
    executable = true;
  };

  systemd.user.services.iitk-net = {
    Unit = {
      Description = "IITK Fortinet Internet Keepalive";
      ConditionPathExists = "%h/.config/iitk-net/credentials";
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
}
