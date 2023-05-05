{ config, lib, pkgs, self, ... }: {
  hardware.ledger.enable = true;
  environment.systemPackages = with pkgs; [ ledger-live-desktop ];
}

