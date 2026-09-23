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

  programs.foot.enable = true;

  xdg.configFile."sway/config".text = ''
    include /etc/sway/config.d/*
    
    set $mod Mod4
    set $term foot
    
    # Terminal
    bindsym $mod+Return exec $term

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
  '';

  home.stateVersion = "26.05";
}
