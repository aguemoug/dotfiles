{ pkgs, ... }:

{
  programs.direnv.enable = true;
  environment.systemPackages = with pkgs; [
  clang-tools 
  lld 
  gcc
  gnumake
  patch
  pkg-config
  autoconf
  automake
  libtool
  file
  binutils
  meson
  valgrind
  cmake
  ninja
  clang
  jdk11
  git
  lazygit
  sqlite
  nodejs
  # LSPs
  python313Packages.python-lsp-server
  lua-language-server
  markdown-oxide
    cmake-language-server
    docker-compose-language-service
    hyprls
    texlab
    tree-sitter
  ];
}
