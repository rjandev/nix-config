{ config, lib, pkgs, ... }:

let home = pkgs.home-manager;
in {
  home.file.".config/polybar/config.ini" = { source = ./config.ini; };
  home.file.".config/polybar/launch.sh" = { source = ./launch.sh; };
}
