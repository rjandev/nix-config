{
  config,
  pkgs,
  callPackage,
  ...
}:

{
  imports = [ ./dunst.nix ];
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw

  services = {

    displayManager = {
      defaultSession = "none+i3";
      autoLogin = {
        enable = true;
        user = "jan";
      };
    };

    xserver = {
      enable = true;
      autorun = true;

      desktopManager = {
        xterm.enable = false;
      };

      displayManager = {
        startx.enable = true;
        gdm = {
          autoLogin.delay = 6;
          enable = true;
        };
      };

      windowManager.i3 = {
        package = pkgs.i3-gaps;
        enable = true;
        extraPackages = with pkgs; [
          j4-dmenu-desktop
          i3status
          i3lock
          i3blocks # if you are planning on using i3blocks over i3status
        ];
      };
    };
  };
}
