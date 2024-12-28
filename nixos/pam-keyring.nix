{ config, pkgs, ... }:

{
  services.gnome.gnome-keyring.enable = true;

  security.polkit.enable = true;

  security.pam.services.gdm = {
    enableGnomeKeyring = true;
  };

  security.pam.services.gdm-autologin.text = ''
    auth       optional ${config.systemd.package}/lib/security/pam_systemd_loadkey.so
  '';

  environment.systemPackages = with pkgs; [ polkit_gnome ];

  # autostart gnome polkit agent
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
