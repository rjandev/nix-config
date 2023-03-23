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
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        j4-dmenu-desktop
        i3status
        i3lock
        #i3blocks #if you are planning on using i3blocks over i3status
      ];
      #extraSessionCommands = ''
      #  eval $(gnome-keyring-daemon --daemonize)
      #  export SSH_AUTH_SOCK
      #'';
    };
  };

  # necessary for gnome keyring to work 
  #xsession.profileExtra = ''
  #  eval $(${pkgs.gnome.gnome-keyring}/bin/gnome-keyring-daemon --daemonize --components=ssh, secrets)
  #  export SSH_AUTH_SOCK
  #'';
  #systemd.user.services.dbus-keyring = {
  #  script = ''
  #    dbus-update-activation-environment --all;
  #    gnome-keyring-daemon --start --components=secrets;
  #  '';
  #  wantedBy = [ "graphical-session.target" ];
  #  partOf = [ "graphical-session.target" ];
  #}; 

}
