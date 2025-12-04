
{ config, lib, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set your time zone to Algeria.
  time.hardwareClockInLocalTime = true;
  time.timeZone = "Africa/Algiers";
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


  # enable network iwd
  networking.wireless.iwd = {
    enable = true;
    settings = {
      General = {
        EnableNetworkConfiguration = true;
      };
      Network = {
        EnableIPv6 = true;
      };
      Scan = {
        DisablePeriodicScan = true;
      };
    };
  };

 # 

  # Enable CUPS to print documents.
  services.printing.enable = true;
  # services.avahi = {
  #   enable = true;
  #   nssmdns4 = true;
  # };



  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };


  nix.settings.auto-optimise-store = true;
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };


# add default users

users.users.sof = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "input" "video" "audio" "tss" ]; 
    initialPassword="1234";
    shell=pkgs.fish;
    packages = with pkgs; [
    youtube-music
    telegram-desktop
    brave
    ];
   };




  environment.systemPackages = with pkgs; [
    iwgtk
    impala

    #audio
    pamixer
    pavucontrol
  ];


}

