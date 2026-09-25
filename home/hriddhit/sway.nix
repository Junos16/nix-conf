{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    grim
    pavucontrol
    slurp
    wl-clipboard
  ];

  programs.foot.enable = true;
  programs.fuzzel.enable = true;
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

  wayland.windowManager.sway = {
    enable = true;
    package = null;

    systemd.enable = true;

    config = {
      modifier = "Mod4";
      terminal = "foot";
      menu = "fuzzel";

      keybindings = lib.mkForce {
        "Mod4+Return" = "exec foot";
        "Mod4+d" = "exec fuzzel";

        "Print" = ''exec grim -g "$(slurp)" - | wl-copy'';
        "Mod4+Shift+s" = ''exec grim -g "$(slurp)" - | wl-copy'';
        "Shift+Print" = "exec grim - | wl-copy";
        "Mod4+s" = "exec grim - | wl-copy";

        "--locked XF86AudioRaiseVolume" = "exec ${pkgs.wireplumber}/bin/wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+";
        "--locked XF86AudioLowerVolume" = "exec ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "--locked XF86AudioMute" = "exec ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

        "Mod4+Ctrl+l" = "exec swaylock -f";
        "Mod4+q" = "kill";

        "Mod4+h" = "focus left";
        "Mod4+j" = "focus down";
        "Mod4+k" = "focus up";
        "Mod4+l" = "focus right";

        "Mod4+Shift+h" = "move left";
        "Mod4+Shift+j" = "move down";
        "Mod4+Shift+k" = "move up";
        "Mod4+Shift+l" = "move right";

        "Mod4+1" = "workspace number 1";
        "Mod4+2" = "workspace number 2";
        "Mod4+3" = "workspace number 3";
        "Mod4+4" = "workspace number 4";
        "Mod4+5" = "workspace number 5";

        "Mod4+Shift+1" = "move container to workspace number 1";
        "Mod4+Shift+2" = "move container to workspace number 2";
        "Mod4+Shift+3" = "move container to workspace number 3";
        "Mod4+Shift+4" = "move container to workspace number 4";
        "Mod4+Shift+5" = "move container to workspace number 5";

        "Mod4+Shift+c" = "reload";
        "Mod4+Shift+e" = "exit";
      };

      modes = { };
      bars = [ ];

      gaps = {
        inner = 6;
        outer = 3;
      };

      window = {
        titlebar = false;
        border = 2;
      };

      startup = [
        { command = "waybar"; }
      ];

      output."*".bg = "#11111b solid_color";
    };
  };

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
        command = ''${pkgs.sway}/bin/swaymsg "output * power off"'';
        resumeCommand = ''${pkgs.sway}/bin/swaymsg "output * power on"'';
      }
    ];

    events = {
      "before-sleep" = "${pkgs.swaylock}/bin/swaylock -f";
    };
  };
}
