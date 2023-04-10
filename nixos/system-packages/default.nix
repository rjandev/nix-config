{ config, pkgs, ... }:

{
  imports = [ # Include other packages within this folder
    ./development.nix
    ./nixos.nix
  ];
  environment.systemPackages = with pkgs; [ vim brave alacritty polkit_gnome ];
}
