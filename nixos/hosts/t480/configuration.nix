
{ config,inputs, lib, pkgs, ... }:
{

  imports = [
    ./hardware-configuration.nix
    ./laptop.nix
  ];

  nixpkgs.config.allowUnfree = true;

  #Boot configuration
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.consoleMode = "0";
    systemd-boot.configurationLimit = 5;
  };

  boot.plymouth.enable = true;
  boot.initrd.systemd.enable = true;
  boot.kernelParams = ["quiet"];

  #boot.loader.efi.canTouchEfiVariables = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];


 # Nix store config
  nix.settings.auto-optimise-store = true;
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  boot.loader.efi.canTouchEfiVariables = true;
  users.users.sof = {
    description = "Soufian";
    home = "/home/sof";
    shell=pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "input" "video" "audio" "tss" ]; 
    isNormalUser = true;
    hashedPassword = "$6$7ETXUFXE7GyyT.Je$HcNQmpL2zIMmb7bvgwMs6iXOLJ/bdKN0Oe4Qhnx7ZbNEXRGgmft1.FHufTGNk.GNzFRcllQmUPPEBbZPnyISM1";
  };

  # Enable Bluetooth

  # Enable services
  services.fwupd.enable = true;
  services.printing.enable = true;


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



  # Enable sound with pipewire.
  #services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };


  programs.fish.enable = true;


# add default users

  environment.systemPackages = with pkgs; [
    avahi
    dmidecode
    freshfetch
    git
    libcamera
    lshw
    unzip
    xz
    zlib
    fish


    # Terminal tools
    neovim
    stow
    kitty
    starship
    moreutils
    file
    delta
    ripgrep
    procs
    aria2
    yt-dlp
    duf
    ncdu
    dust
    fd
    zoxide
    tokei
    fzf
    bat
    hexyl
    mdcat
    pandoc
    lsd
    viu
    tre-command
    yazi
    chafa
    jrnl
    rsclock
    cava
    figlet
    lolcat
    cbonsai
    #wirless
    iwgtk
    impala
    #audio
    pamixer
    pavucontrol
  ];


  # Fonts
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-font-patcher
    noto-fonts-color-emoji
    liberation_ttf
    dejavu_fonts
    noto-fonts
    font-awesome

  ];
}


