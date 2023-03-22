{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs; [
    vim
    git
    brave
    jetbrains.idea-ultimate
  ];
}
