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
    yazi
    
    qpdfview
    krita
    rnote

    spotify
    discord
    zoom

    wl-clipboard
    grim
    slurp

    pavucontrol
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

  programs.foot.enable = true;
  programs.fuzzel.enable = true;
  programs.zathura.enable = true;
  programs.firefox.enable = true;

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
  };
 
  programs.swaylock.enable = true;

  programs.waybar = {
    enable = true;
    
    settings = {
      mainBar = {
        layer = "top";
        position = "top";

        modules-left = [
          "sway/workspaces"
        ];
  
        modules-center = [
          "sway/window"
        ];

        modules-right = [
	  "pulseaudio"
          "clock"
        ];
   
        clock = {
          format = "{:%a %d %b  %H:%M}";
        };
         
        pulseaudio = {
          format = "{volume}%";
          format-muted = "mute";

          on-click = "pavucontrol";
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-size: 13px;
      }
 
      window#waybar {
        background: #1e1e2e;
        color: #cdd6f4;
      }

      #workspaces button {
        padding: 0 8px;
        color: #a6adc8;
      }

      #workspaces button.focused {
        color: #ffffff;
      }

      #clock {
        padding: 0 10px;
      }
    '';
  };

  xdg.configFile."sway/config".text = ''
    include /etc/sway/config.d/*
    
    set $mod Mod4
    set $term foot
    set $menu fuzzel
    
    # Terminal
    bindsym $mod+Return exec $term

    # Menu
    bindsym $mod+d exec $menu

    # Screenshots
    bindsym Print exec grim -g "$(slurp)" - | wl-copy
    bindsym $mod+Shift+s  exec grim -g "$(slurp)" - | wl-copy
    bindsym Shift+Print exec grim - | wl-copy
    bindsym $mod+s exec grim - | wl-copy

    # Lockscreen 
    bindsym $mod+Ctrl+l exec swaylock -f

    #Close focused window
    bindsym $mod+Shift+q kill

    # Focus
    bindsym $mod+h focus left
    bindsym $mod+j focus down
    bindsym $mod+k focus up
    bindsym $mod+l focus right

    # Move windows
    bindsym $mod+Shift+h move left
    bindsym $mod+Shift+j move down
    bindsym $mod+Shift+k move up
    bindsym $mod+Shift+l move right

    # Workspaces
    bindsym $mod+1 workspace number 1
    bindsym $mod+2 workspace number 2
    bindsym $mod+3 workspace number 3
    bindsym $mod+4 workspace number 4
    bindsym $mod+5 workspace number 5

    bindsym $mod+Shift+1 move container to workspace number 1
    bindsym $mod+Shift+2 move container to workspace number 2
    bindsym $mod+Shift+3 move container to workspace number 3
    bindsym $mod+Shift+4 move container to workspace number 4
    bindsym $mod+Shift+5 move container to workspace number 5

    gaps inner 6
    gaps outer 3
    default_border pixel 2

    bindsym $mod+Shift+c reload
    bindsym $mod+Shift+e exit
    
    exec waybar
    output * bg #11111b solid_color
  '';

  services.mako.enable = true;
  services.polkit-gnome.enable = true;

  services.swayidle = {
    enable = true;

    timeouts = [
      {
        timeout = 600;
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }

      {
	timeout = 900;
	command = "${pkgs.sway}/bin/swaymsg \"output * power off\"";
	resumeCommand = "${pkgs.sway}/bin/swaymsg \"output * power on\"";
      }
    ];

    events = {
      "before-sleep" = "${pkgs.swaylock}/bin/swaylock -f";
    };
  };


  home.stateVersion = "26.05";
}
