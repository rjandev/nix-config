{ config, pkgs, ... }:

{
  imports = [ # Include other packages within this folder
    ./development.nix
    ./nixos.nix
  ];
  environment.systemPackages = with pkgs; [ # #
    brave
    alacritty
    htop
    signal-desktop
    ncdu
  ];

  programs.vim.defaultEditor = true;
}
