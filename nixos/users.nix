{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.

users.users.sof = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" "input" "video" "audio" "tss" ]; # Enable ‘sudo’ for the user.
     initialPassword="1234";
     shell=pkgs.fish;

    packages = with pkgs; [
      youtube-music
      telegram-desktop
      brave
    ];
   };
}
