{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs; [
    vim
    git
    brave
    jetbrains.idea-ultimate
    alacritty
    jetbrains-mono
    polkit_gnome
  ];
}
