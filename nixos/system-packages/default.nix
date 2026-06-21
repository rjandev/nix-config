{ config, pkgs, ... }:

{
  imports = [
    # Include other packages within this folder
    ./development.nix
    ./nixos.nix
    ./mounts.nix
  ];

  services.udev.packages = [ pkgs.vial ];

  environment.systemPackages = with pkgs; [
    # #
    brave
    alacritty
    htop
    signal-desktop
    ncdu
    playerctl
    vial
    thunar
    thunar-volman
    bat
    unstable.sbctl
  ];

  programs.vim.enable = true;
  programs.vim.defaultEditor = true;
}
