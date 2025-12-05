{
  description = "Abdessettar's NixOS Configuration";
  inputs.nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { nixpkgs, ... } @ inputs:
  {
    nixosConfigurations = {
      sof-box = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
       modules = [
      ./configuration.nix
      ./local.nix
      ./dev-tools.nix
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
      ./hosts/t480/configuration.nix
      ./local.nix
      ./dev-tools.nix
      ./hyprland.nix
       # ./tex.nix
       # ./video.nix
      ./office.nix
	];
    	};
    };

  };
}
