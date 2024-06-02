{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    usbutils
    udiskie
    udisks
  ];

  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}
