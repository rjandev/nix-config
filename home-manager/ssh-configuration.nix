{ config, pkgs, ... }:

let
  sshConfig = ''

    Host github.com
      HostName github.com
      User git
      IdentityFile ~/.ssh/github-ssh.pub
      IdentitiesOnly yes

    Host gitlab.com
          HostName gitlab.com
          User git
          IdentityFile ~/.ssh/gitlab-ssh.pub
          IdentitiesOnly yes

    Host raspberrypi
          HostName raspberrypi
          User pi
          IdentityFile ~/.ssh/raspberry3b-ssh.pub
          IdentitiesOnly yes

    Host *
      IdentityAgent ~/.1password/agent.sock
  '';

in {
  home.file.".ssh/config".text = sshConfig;
  home.file.".ssh/github-ssh.pub" = { source = ./github-ssh.pub; };
  home.file.".ssh/gitlab-ssh.pub" = { source = ./gitlab-ssh.pub; };
  home.file.".ssh/raspberry3b-ssh.pub" = { source = ./raspberry3b-ssh.pub; };
}

