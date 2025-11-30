{
  description = "Abdessettar's NixOS Configuration";

  inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { nixpkgs, ... } @ inputs:
  {
    nixosConfigurations = {

    	sof-box = nixpkgs.lib.nixosSystem {
      	specialArgs = { inherit inputs; };
      		modules = [
      ./hardware-configuration.nix
      ./configuration.nix
      ./boot.nix
      ./dev-tools.nix
      ./consol.nix
      ./terminal.nix
      ./users.nix
      ./hyprland.nix
      ./sound.nix
      # ./tex.nix
     # ./video.nix
      ./office.nix
      ./settings.nix
	];
    	};
    };
  };
}
