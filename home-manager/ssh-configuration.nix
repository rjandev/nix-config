{ config, pkgs, ... }:

let
  sshConfig = ''
    Host *
	IdentityAgent ~/.1password/agent.sock
  '';

in {
  home.file.".ssh/config".text = sshConfig;
}
