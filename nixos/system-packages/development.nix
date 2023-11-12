{ config, pkgs, ... }:

{

  imports = [
    # install custom/latest version of jetbrains products without using unstable channel
    ./jetbrains/default.nix
    ./docker.nix
  ];

  nixpkgs.overlays = [
    (self: super: {
      gradle = super.gradle.override {
        java = super.jdk;
        javaToolchains = [ super.jdk super.jdk17 ];
      };
    })
  ];

  environment.systemPackages = with pkgs; [ # #
    git
    jetbrains-mono
    kotlin
    jdk
    jdk17
    gradle
    yarn
    nodejs
    unstable.jetbrains.rust-rover
  ];

  programs.java = { enable = true; };

}
