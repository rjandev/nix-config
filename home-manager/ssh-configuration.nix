{ config, pkgs, ... }:

let
  sshConfig = ''

    Host github.com
      HostName github.com
      User git
      IdentityFile ~/.ssh/github-ssh.pub
      IdentitiesOnly yes

    Host *
      IdentityAgent ~/.1password/agent.sock
  '';

in {
  home.file.".ssh/config".text = sshConfig;
  home.file.".ssh/github-ssh.pub" = { source = ./github-ssh.pub; };
}

