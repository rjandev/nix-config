{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, B, exec, brave"
        "$mod, return, exec, alacritty"
        "$mod, D, exec, bemenu-run"
        "$mod, P, exec, bemenu-run"
        ", Print, exec, grimblast copy area"
      ] ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (x:
          let ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
          in [
            "$mod, ${ws}, workspace, ${toString (x + 1)}"
            "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
          ]) 10));
    };
    extraConfig = ''
      env = LIBVA_DRIVER_NAME,nvidia
      env = XDG_SESSION_TYPE,wayland
      env = GBM_BACKEND,nvidia-drm
      env = __GLX_VENDOR_LIBRARY_NAME,nvidia
      env = WLR_NO_HARDWARE_CURSORS,1
      env = WLR_RENDERER,vulkan

      monitor=HDMI-A-1, 1366x768, 0x0, 1
      monitor=DP-1, 1920x1080@144, 1366x0, 1
      monitor=DP-2, 1920x1200, 3286x0, 1
     
      misc {
        disable_hyprland_logo = true
      }
    '';
  };
}
