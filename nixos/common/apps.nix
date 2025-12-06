{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
  nemo-with-extensions
    firefox
    brave
    libreoffice               # full office suite (Writer, Calc, Impress, etc.)
    obsidian                  # Markdown-based note-taking
    xournalpp                 # Handwritten notes, PDFs annotation
    kdePackages.okular                     # PDF reader / annotator
    evince                     # Lightweight PDF viewer
    typora                     # Markdown editor
    kdePackages.ghostwriter                # Markdown-focused distraction-free editor
    thunderbird                # Email client
    evolution                  # Email + calendar (optional)
    slack
    zoom
    discord
    telegram-desktop
    jabref                      # Manage BibTeX references
    youtube-music
  ];

  # Optional: enable clipboard integration for GUI apps
}
