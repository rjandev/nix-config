{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs; [
    vim
    git
    brave
    unstable.jetbrains.idea-ultimate
    alacritty
    jetbrains-mono
    polkit_gnome
  ];
}
