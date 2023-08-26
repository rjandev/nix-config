{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
  home = pkgs.home-manager;
in {

  xsession = {
    enable = true;
    initExtra = ''
      dbus-update-activation-environment --all
      export SSH_AUTH_SOCK
    '';
  };

  # install i3
  home.packages = [ pkgs.i3-gaps ];
  home.file.".config/i3/config".text = ''
    set $mod Mod4

    # Font for window titles. Will also be used by the bar unless a different font
    # is used in the bar {} block below.
    font pango: JetBrains Mono

    # This font is widely installed, provides lots of unicode glyphs, right-to-left
    # text rendering and scalability on retina/hidpi displays (thanks to pango).
    #font pango:DejaVu Sans Mono 8

    # The combination of xss-lock, nm-applet and pactl is a popular choice, so
    # they are included here as an example. Modify as you see fit.

    # xss-lock grabs a logind suspend inhibit lock and will use i3lock to lock the
    # screen before suspend. Use loginctl lock-session to lock your screen.
    exec --no-startup-id xss-lock --transfer-sleep-lock -- i3lock --nofork

    # nvidia prime (used to use internal graphics to connect monitor)
    #exec_always --no-startup-id "xrandr --setprovideroutputsource modesetting NVIDIA-0 && xrandr --auto && xrandr --output DP-1 --refresh 144 && xrandr --output DVI-I-1 --right-of DP-1 && xrandr --output VGA-1-1 --left-of DP-1 --rotation left"

    # set screen resolution
    exec_always --no-startup-id "xrandr --auto && xrandr --output DP-2 --refresh 120 && xrandr --output DP-1 --right-of DP-2 && xrandr --output HDMI-0 --left-of DP-2"

    # background image
    # exec_always --no-startup-id "nitrogen --restore"

    # NetworkManager is the most popular way to manage wireless networks on Linux,
    # and nm-applet is a desktop environment-independent system tray GUI for it.
    # exec --no-startup-id nm-applet

    # Use pactl to adjust volume in PulseAudio.
    set $refresh_i3status killall -SIGUSR1 i3status
    bindsym XF86AudioRaiseVolume exec --no-startup-id amixer -D pulse sset Master 5%+ && $refresh_i3status
    bindsym XF86AudioLowerVolume exec --no-startup-id amixer -D pulse sset Master 5%- && $refresh_i3status
    bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status
    bindsym XF86AudioMicMute exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status
    bindsym XF86AudioPlay exec playerctl play-pause
    bindsym XF86AudioPause exec playerctl pause
    bindsym XF86AudioNext exec playerctl next
    bindsym XF86AudioPrev exec playerctl previous

    # Use Mouse+$mod to drag floating windows to their wanted position
    floating_modifier $mod

    # start a terminal
    bindsym $mod+Return exec $TERMINAL

    # kill focused window
    bindsym $mod+x kill

    # start dmenu (a program launcher)
    bindsym $mod+d exec --no-startup-id $LAUNCHER
    bindsym $mod+p exec --no-startup-id $LAUNCHER

    # change focus
    bindsym $mod+h focus left
    bindsym $mod+j focus down
    #bindsym $mod+k focus up
    bindsym $mod+l focus right

    # move focused window
    bindsym $mod+Shift+h move left
    bindsym $mod+Shift+j move down
    bindsym $mod+Shift+k move up
    bindsym $mod+Shift+l move right

    # split in horizontal orientation
    bindsym $mod+h split h

    # split in vertical orientation
    bindsym $mod+v split v

    # enter fullscreen mode for the focused container
    bindsym $mod+f fullscreen toggle

    # change container layout (stacked, tabbed, toggle split)
    bindsym $mod+s layout stacking
    bindsym $mod+w layout tabbed
    bindsym $mod+e layout toggle split

    # toggle tiling / floating
    bindsym $mod+Shift+space floating toggle

    # change focus between tiling / floating windows
    bindsym $mod+space focus mode_toggle

    # focus the parent container
    bindsym $mod+a focus parent

    # focus the child container
    #bindsym $mod+d focus child

    # Define names for default workspaces for which we configure key bindings later on.
    # We use variables to avoid repeating the names in multiple places.
    set $ws1 "1"
    set $ws2 "2"
    set $ws3 "3"
    set $ws4 "4"
    set $ws5 "5"
    set $ws6 "6"
    set $ws7 "7"
    set $ws8 "8"
    set $ws9 "9"
    set $ws10 "10"
    set $wsb "browser"
    set $music "music"
    set $work1 "work (1)"
    set $work2 "work (2)"
    set $work3 "work (3)"

    # switch to workspace
    bindsym $mod+1 workspace number $ws1
    bindsym $mod+2 workspace number $ws2
    bindsym $mod+3 workspace number $ws3
    bindsym $mod+4 workspace number $ws4
    bindsym $mod+5 workspace number $ws5
    bindsym $mod+6 workspace number $ws6
    bindsym $mod+7 workspace number $ws7
    bindsym $mod+8 workspace number $ws8
    bindsym $mod+9 workspace number $ws9
    bindsym $mod+0 workspace number $ws10
    #bindsym $mod+b workspace $wsb

    # bind workspace to monitor
    workspace $ws1 output DP-1
    workspace $ws2 output DVI-I-1
    workspace $ws10 output HDMI-0
    workspace $work1 output DP-1    # always open work1 on main monitor
    workspace $work2 output DVI-I-1 # and work 2 on second/right monitor
    workspace $work3 output HDMI-0

    # move focused container to workspace
    bindsym $mod+Shift+1 move container to workspace number $ws1
    bindsym $mod+Shift+2 move container to workspace number $ws2
    bindsym $mod+Shift+3 move container to workspace number $ws3
    bindsym $mod+Shift+4 move container to workspace number $ws4
    bindsym $mod+Shift+5 move container to workspace number $ws5
    bindsym $mod+Shift+6 move container to workspace number $ws6
    bindsym $mod+Shift+7 move container to workspace number $ws7
    bindsym $mod+Shift+8 move container to workspace number $ws8
    bindsym $mod+Shift+9 move container to workspace number $ws9
    bindsym $mod+Shift+0 move container to workspace number $ws10

    # switch focus to left/right monitor
    bindsym $mod+comma workspace prev
    bindsym $mod+period workspace next
    # move focused workspace left/right
    bindsym $mod+Shift+comma move workspace to output left
    bindysm $mod+Shift+period move workspace to output right

    # reload the configuration file
    bindsym $mod+Shift+r reload
    # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
    bindsym $mod+q restart
    # exit i3 (logs you out of your X session)
    # bindsym $mod+Shift+q exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'"

    # resize window (you can also use the mouse for that)
    mode "resize" {
            # These bindings trigger as soon as you enter the resize mode

            bindsym h resize shrink width 10 px or 10 ppt
            bindsym j resize grow height 10 px or 10 ppt
            bindsym k resize shrink height 10 px or 10 ppt
            bindsym l resize grow width 10 px or 10 ppt

            # back to normal: Enter or Escape or $mod+r
            bindsym Return mode "default"
            bindsym Escape mode "default"
            bindsym $mod+r mode "default"
    }

    bindsym $mod+r mode "resize"

    # Defining colors
    set $bg      #282A36
    set $fg      #f8f8f2
    set $cyan    #8be9fd
    set $green   #50fa7b
    set $magenta #ff79c6
    set $purple  #bd93f9

    # Start i3bar to display a workspace bar (plus the system information i3status
    # finds out, if available)
    bar {
            status_command i3blocks
            position top
    	i3bar_command i3bar -t
    	font pango: Jetbrains mono # SauceCodePro Nerd Font Black 10
    	colors
    	{
        #                   Border Background Text
    		focused_workspace   $fg    $fg        $bg
    		active_workspace    $bg    $bg        $purple
    		inactive_workspace  $bg    $bg        $cyan
    		urgent_workspace    $bg    $bg        $magenta
    		background          $bg
     	}
    }

    for_window [class=".*"] border pixel 0

    # gaps
    smart_gaps on
    gaps inner 3
    gaps outer 0

    # Customizing
    assign [class="Firefox"] browser
    assign [class="Brave"] browser
    bindsym $mod+Shift+b move container to workspace $wsb
    bindsym $mod+b workspace browser; exec pidof $BROWSER >/dev/null || exec $BROWSER

    for_window [class="Spotify"] move to workspace $music, workspace $music

    # work
    for_window [class="Virt-viewer" title="1"] move to workspace $work1, workspace $work1
    for_window [class="Virt-viewer" title="2"] move to workspace $work2, workspace $work2
    for_window [class="Virt-viewer" title="3"] move to workspace $work3, workspace $work3
    for_window [class="xfreerdp" ] move to workspace $work1, workspace $work1, floating enable
    for_window [window_type="_NET_WM_WINDOW_TYPE_NOTIFICATION"] floating enable

    # enable floating for popups
    for_window [window_role="pop-up"] floating enable
    for_window [window_role="bubble"] floating enable
    for_window [window_role="task_dialog"] floating enable
    for_window [window_role="Preferences"] floating enable
    for_window [window_type="dialog"] floating enable
    for_window [window_type="menu"] floating enable

    # open chrome right to current monito
    #assign [class="Chromium"] → output right

    # Jetbrains toolbox floating
    for_window [class="jetbrains-toolbox"] floating enable

    # betterlockscreen / i3lock
    #bindsym $mod+l exec betterlockscreen -l dim
  '';
}
