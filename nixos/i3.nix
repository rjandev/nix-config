{ config, pkgs, callPackage, ... }:

{
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw

  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
        defaultSession = "none+i3";
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        j4-dmenu-desktop
        i3status
        i3lock
        #i3blocks #if you are planning on using i3blocks over i3status
      ];
    };
  };
}
