{ pkgs, ... }:

{

 # Nix store config
  users.users.sof = {
    description = "Soufian";
    home = "/home/sof";
    shell=pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "input" "video" "audio" "tss" ]; 
    isNormalUser = true;
    hashedPassword = "$6$7ETXUFXE7GyyT.Je$HcNQmpL2zIMmb7bvgwMs6iXOLJ/bdKN0Oe4Qhnx7ZbNEXRGgmft1.FHufTGNk.GNzFRcllQmUPPEBbZPnyISM1";
  };

}
