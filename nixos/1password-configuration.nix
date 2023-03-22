{ config, pkgs, ... }:

{
  programs._1password-gui.enable = true;
  programs._1password-gui.polkitPolicyOwners = ["jan"];
}
