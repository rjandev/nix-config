{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
in {

  # necessary for gnome keyring to work
  
#  services = {
#    gnome-keyring = {
#      enable = true;
#      components = ["pkcs11" "secrets" "ssh" ];
#    };
#  };

  xsession = {
    enable = true;
    initExtra = ''
      dbus-update-activation-environment --all
      #gnome-keyring-daemon --start --components=secrets
      #eval $(gnome-keyring-daemon --start --components=pkcs11,ssh,secrets)
      export SSH_AUTH_SOCK
    '';
  };

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;

      fonts = ["JetBrains Mono, DejaVu Sans Mono, FontAwesome 6"];

      keybindings = lib.mkOptionDefault {

        # media controls
        "XF86AudioRaiseVolume" = "exec --no-startup-id amixer -D pulse sset Master 5%+ && killall -SIGUSR1 i3status";
        "XF86AudioLowerVolume" = "exec --no-startup-id amixer -D pulse sset Master 5%- && killall -SIGUSR1 i3status";
        "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && killall -SIGUSR1 i3status";
        "XF86AudioMicMute" = "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && killall -SIGUSR1 i3status";
        "XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioPause" = "exec playerctl pause";
        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioPrev" = "exec playerctl previous";

        # terminal
        "${mod}+Return" = "exec $TERMINAL";

        # launcher
        "${mod}+d" = "exec --no-startup-id $LAUNCHER #j4-dmenu-desktop";
        "${mod}+p" = "exec --no-startup-id $LAUNCHER";

        # Focus
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        # Move
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";

        # split in horizontal orientation
        #"${mod}+h" = "split h";

        # split in vertical orientation
        "${mod}+v" = "split v";

        # My multi monitor setup
        #"${mod}+m" = "move workspace to output DP-2";
        #"${mod}+Shift+m" = "move workspace to output DP-5";
      };

      bars = [
        {
          position = "top";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${./i3status-rust.toml}";
        }
      ];
    };
  };
}
