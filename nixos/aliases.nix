{ config, inputs, lib, pkgs, self, ... }:

{
  environment = {

    shellAliases = let ifSudo = lib.mkIf config.security.sudo.enable;
    in {
      # nix rebuild
      nrt = ifSudo "sudo nixos-rebuild test --flake .#jan-pc";
      nrs = ifSudo "sudo nixos-rebuild switch --flake .#jan-pc";
      nrsu = ifSudo "sudo nixos-rebuild switch --upgrade --flake .#jan-pc";
      # nix-env with system-profile
      nsp = ifSudo "sudo nix-env --profile /nix/var/nix/profiles/system";
      # list all generations
      nlg = ifSudo "nsp --list-generations";
      # delete generations; e.g. ndg 30d -> older than 30d; ndg +5 -> keep the last 5
      ndg = ifSudo "nsp --delete-generations";
      # run garbage collector
      ncg = ifSudo "sudo nix-store --gc";
      # update all lockfile
      nul = ifSudo "nix --extra-experimental-features nix-command --extra-experimental-features flakes flake update";
    };
  };
}
