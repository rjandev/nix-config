{ config, pkgs, ... }:

{
  virtualisation.docker.enable = true;

  users.users.jan.extraGroups = [ "docker" ];

  environment.systemPackages = with pkgs; [ docker-compose ];
}
