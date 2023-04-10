{ config, lib, pkgs, self, ... }: {
  hardware.ledger.enable = true;
  environment.systemPackages = with pkgs; [ unstable.ledger-live-desktop ];
}

