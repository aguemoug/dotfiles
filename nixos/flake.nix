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
      ./local.nix
      ./dev-tools.nix
      ./terminal.nix
      ./hyprland.nix
       # ./tex.nix
       # ./video.nix
      ./office.nix
	];
    	};

      # Laptop 
      sof-laptop = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
       modules = [
      ./hardware-configuration.nix
      ./configuration.nix
      ./laptop.nix
      ./local.nix
      ./dev-tools.nix
      ./terminal.nix
      ./hyprland.nix
       # ./tex.nix
       # ./video.nix
      ./office.nix
	];
    	};
    };

  };
}
