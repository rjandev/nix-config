{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    jetbrains.jdk
    jetbrains.idea-ultimate
    jetbrains-mono
    kotlin
  ];

  programs.java = { enable = true; };

}
