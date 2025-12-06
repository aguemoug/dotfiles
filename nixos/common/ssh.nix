



{ config,inputs, lib, pkgs, ... }:
{

  programs.ssh.startAgent = true;
  programs.ssh.extraConfig =''
  Host github.com
  IdentityFile   ~/.ssh/github_key
  '';

  # Enable the OpenSSH daemon.

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "yes";
      AllowUsers = [ "sof" "root"];
    };
  };

}

