{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    unstable.jetbrains.idea-ultimate
    jetbrains-mono
    unstable.kotlin
  ];

  programs.java = { enable = true; };

}
