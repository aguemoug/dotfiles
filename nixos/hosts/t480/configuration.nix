
{ config,inputs, lib, pkgs, ... }:
{

  imports = [
    ./hardware-configuration.nix
    ../../common/apps.nix
    ../../common/audio.nix
    ../../common/boot.nix
    ../../common/cli.nix
    ../../common/dev.nix
    ../../common/fonts.nix
    ../../common/hyprland.nix
    ../../common/networking.nix
    ../../common/nix-settings.nix
    ../../common/printer.nix
    ../../common/ssh.nix
    ../../common/time.nix
    ../../common/users.nix
  ];



# networking.networkmanager.wifi.powersave.enable=true;

  services.fwupd.enable = true;

  #hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;
  # For thinkpad
  services.tlp.enable = true;
  # Battery power management
  services.upower.enable = true;

  programs.light.enable = true;
  environment.systemPackages = with pkgs; [
    brightnessctl
    wireguard-tools
  ];

 services = {
    libinput = {
      enable = true;
      touchpad = {
        scrollMethod = "twofinger";
      };
    };
    };
}


