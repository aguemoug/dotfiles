
{ config,inputs, lib, pkgs, ... }:
{

  #Boot configuration
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.consoleMode = "0";
    systemd-boot.configurationLimit = 5;
  };

  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.systemd.enable = true;
  boot.plymouth.enable = true;
  boot.kernelParams = ["quiet"];

}
