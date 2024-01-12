{ config, pkgs, ... }: {

  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  security.pam.services.lightdm.fprintAuth = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;
}
