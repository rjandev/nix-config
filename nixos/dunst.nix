{ config, lib, pkgs, self, ... }: { environment.systemPackages = with pkgs; [ libnotify dunst ]; }
