{ pkgs, ... }:

{
  # Enable GUI applications if needed
  environment.systemPackages = with pkgs; [
    # Video recording / streaming
    obs-studio

    # Video editors
   kdePackages.kdenlive
    shotcut
    pitivi
    blender           # for more advanced VFX / 3D animation

    # Audio editing
    audacity

    # Command-line tools for video/audio
    ffmpeg             # essential CLI video/audio processing
    sox                # sound processing
    mpv                # media player

    # Optional helpful utilities
    imagemagick        # image conversion / manipulation
    vlc                # media player
    uxplay   # Screen cast server
  ];

  # Optional: enable PulseAudio (if not already enabled)
}
