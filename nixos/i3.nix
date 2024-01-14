{ config, pkgs, callPackage, ... }:

{
  imports = [ ./dunst.nix ];
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw

  services.xserver = {
    enable = true;
    autorun = true;

    desktopManager = { xterm.enable = false; };

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
      extraPackages = with pkgs; [ j4-dmenu-desktop i3lock ];
    };
  };

  environment.systemPackages = with pkgs;
    let polybar = pkgs.polybar.override { i3Support = true; };
    in [
      polybar
      # the rest of your packages
    ];
}
