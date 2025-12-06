
{ pkgs, ... }:

{

networking.usePredictableInterfaceNames = false;

systemd.network.links."eth0.rename"=  {
  matchConfig.PermanentMACAddress="98:FA:9B:33:84:22";
  linkConfig.Name ="eno1";
};

networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
  nmgui
  ];

}
