{inputs, pkgs, ... }:
{


  # ...
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    packages = with pkgs; [ terminus_font ];
    keyMap = "us";
  };

  programs.fish.enable = true;
  environment.systemPackages = with pkgs; [
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
  ];
}
