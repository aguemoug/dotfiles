
{ pkgs,inputs,outputs,lib, ... }:

{


networking.usePredictableInterfaceNames = false;
systemd.network.links."eth0.rename"=  {
  matchConfig.PermanentMACAddress="98:FA:9B:33:84:22";
  linkConfig.Name ="eno1";
};
  programs.light.enable = true;



#hardware.pulseaudio.enable = true;
hardware.bluetooth.enable = true;
# For thinkpad
services.tlp.enable = true;

# Battery power management
services.upower.enable = true;

environment.systemPackages = with pkgs; [
    brightnessctl
    wireguard-tools
  ];

 services = {
    libinput = {
      enable = true;
      touchpad = {
        scrollMethod = "twofinger";
      };
    };
    };

}
