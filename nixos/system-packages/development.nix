{ config, pkgs, ... }:

{

  imports = [
    # install custom/latest version of jetbrains products without using unstable channel
    ./jetbrains/default.nix
  ];

  environment.systemPackages = with pkgs; [ # #
    git
    jetbrains-mono
    kotlin
    jdk17
    gradle
    yarn
  ];

  programs.java = { enable = true; };

}
