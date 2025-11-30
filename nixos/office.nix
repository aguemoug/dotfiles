{ pkgs, ... }:

{


  environment.systemPackages = with pkgs; [
    # Office suite
    libreoffice               # full office suite (Writer, Calc, Impress, etc.)
    # Note-taking / knowledge management
    obsidian                  # Markdown-based note-taking
    xournalpp                 # Handwritten notes, PDFs annotation
    # PDF tools
    kdePackages.okular                     # PDF reader / annotator
    evince                     # Lightweight PDF viewer
    # Text editors
    typora                     # Markdown editor
    kdePackages.ghostwriter                # Markdown-focused distraction-free editor
    # Email / Calendar
    thunderbird                # Email client
    evolution                  # Email + calendar (optional)
    # Communication / Collaboration
    slack
    zoom
    discord
    # Reference / bibliographies
    jabref                      # Manage BibTeX references
    zotero                      # Citation manager (via nixpkgs package or flatpak)
  ];

  # Fonts
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-font-patcher
    noto-fonts-color-emoji
    liberation_ttf
    dejavu_fonts
    noto-fonts
  ];
  # Optional: enable clipboard integration for GUI apps
}
