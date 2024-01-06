{ config, pkgs, ... }: {

  #autologin
  services.getty.autologinUser = "jan";

  environment.systemPackages = with pkgs; [
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    libva
    bemenu
  ];
}
