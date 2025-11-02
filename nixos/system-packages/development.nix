{ config, pkgs, ... }:

{

  imports = [ ./docker.nix ];

  nixpkgs.overlays = [
    (self: super: {
      gradle = super.gradle.override {
        java = super.jdk;
        javaToolchains = [
          super.jdk
          super.jdk17
          super.jdk21
        ];
      };
    })
  ];

  fonts.packages = with pkgs; [ jetbrains-mono ];

  environment.systemPackages = with pkgs; [
    # #
    git
    kotlin
    jdk
    jdk17
    jdk21
    gradle
    yarn
    nodejs
    jetbrains.idea-ultimate
    unstable.jetbrains.goland
    unstable.jetbrains.rust-rover
    gcc
    rustup
    rustc
    go
    kubectl
    kubernetes-helm
  ];

  programs.java = {
    enable = true;
  };

  programs.direnv.enable = true;
}
