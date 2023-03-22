{ config, pkgs, ... }:

{
   users.users.jan.packages = with pkgs; [
      brave
    ];
}
