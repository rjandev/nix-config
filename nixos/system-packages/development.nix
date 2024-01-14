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
        javaToolchains = [ super.jdk super.jdk17 super.jdk21 ];
      };
    })
  ];

  fonts.packages = with pkgs; [ jetbrains-mono ];

  environment.systemPackages = with pkgs; [ # #
    git
    kotlin
    jdk
    jdk17
    jdk21
    gradle
    yarn
    nodejs
    unstable.jetbrains.rust-rover
    gcc
    rustup
    rustc
  ];

  programs.java = { enable = true; };

}
