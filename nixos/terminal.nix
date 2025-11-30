{inputs, pkgs, ... }:
{
  programs.fish.enable = true;
  environment.systemPackages = with pkgs; [
    neovim
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
