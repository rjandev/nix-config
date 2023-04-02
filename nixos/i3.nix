{ config, pkgs, callPackage, ... }:

{
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw

  services.xserver = {
    enable = true;
    autorun = true;

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
        defaultSession = "none+i3";
        startx.enable = true;
        lightdm.enable = true;
        autoLogin = {
          enable = true;
          user = "jan";
        };
    };

    windowManager.i3 = {
      package = pkgs.i3-gaps;
      enable = true;
      extraPackages = with pkgs; [
        j4-dmenu-desktop
        i3status
        i3lock
        i3blocks #if you are planning on using i3blocks over i3status
      ];
    };
  };
}
