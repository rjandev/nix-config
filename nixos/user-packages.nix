{ config, pkgs, ... }:

{
  users.users.jan.packages = with pkgs; [
    # prefer system packages to avoid conflicts etc.
  ];
}
