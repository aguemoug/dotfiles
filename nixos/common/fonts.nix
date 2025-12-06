{ pkgs, ... }:

{
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
