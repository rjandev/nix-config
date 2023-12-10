{ config, pkgs, ... }:

{
  imports = [ # Include other packages within this folder
    ./development.nix
    ./nixos.nix
  ];

  services.udev.packages = [ pkgs.vial ];

  environment.systemPackages = with pkgs; [ # #
    brave
    alacritty
    htop
    signal-desktop
    ncdu
    playerctl
    vial
    fzf
    fzf-obc
    fzf-git-sh
  ];

  programs.vim.defaultEditor = true;
}
