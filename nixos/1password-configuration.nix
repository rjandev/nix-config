{ config, pkgs, ... }:

{
  programs._1password.enable = true;
  programs._1password.package = pkgs.unstable._1password-cli;
  programs._1password-gui.enable = true;
  programs._1password-gui.polkitPolicyOwners = [ "jan" ];
}
