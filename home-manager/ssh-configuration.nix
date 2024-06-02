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
      HostName 192.168.178.36
      User pi
      IdentityFile ~/.ssh/raspberry3b-ssh.pub
      IdentitiesOnly yes

    Host raspberrypi-jan-001
      HostName raspberrypi-jan-001
      User pi
      IdentityFile ~/.ssh/raspberry5-ssh.pub
      IdentitiesOnly yes

    Host *
      IdentityAgent ~/.1password/agent.sock
      SetEnv TERM=xterm
  '';
in
{
  home.file.".ssh/config".text = sshConfig;
  home.file.".ssh/github-ssh.pub" = {
    source = ./github-ssh.pub;
  };
  home.file.".ssh/gitlab-ssh.pub" = {
    source = ./gitlab-ssh.pub;
  };
  home.file.".ssh/raspberry3b-ssh.pub" = {
    source = ./raspberry3b-ssh.pub;
  };
  home.file.".ssh/raspberry5-ssh.pub" = {
    source = ./raspberry5-ssh.pub;
  };
}
