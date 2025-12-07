

{ config,inputs, lib, pkgs, ... }:
{


  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    avahi
    dmidecode
    freshfetch
    pass
    gnupg
    passepartui
    git
    libcamera
    lshw
    unzip
    xz
    zlib
    fish
    tree
    wget
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


}


