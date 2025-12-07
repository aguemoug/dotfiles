{ pkgs, ... }:

{
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
#    withUWSM = true;
  };

  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user    = "greeter";
      };
    };
  };
  environment.systemPackages = with pkgs; [
    pyprland
    hyprpicker
    hyprcursor
    hyprlock
    hypridle
    hyprpaper
    hyprsunset
    hyprpolkitagent
    walker
    waybar
    wlogout
    hyprlauncher
    nwg-look
#    rose-pine-hyprcursor
  ];
}
