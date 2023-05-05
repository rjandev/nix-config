{ config, pkgs, ... }:

{

  imports = [
    # install custom/latest version of jetbrains products without using unstable channel
    ./jetbrains/default.nix
  ];

  environment.systemPackages = with pkgs; [
    git
    #jetbrains.jdk jetbrains.idea-ultimate
    jetbrains-mono
    kotlin
  ];

  programs.java = { enable = true; };

}
