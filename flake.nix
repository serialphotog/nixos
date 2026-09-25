{
  description = "Adam's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, nixpkgs-unstable, ... }:
    {
      nixosConfigurations.Lappy = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit nixpkgs-unstable; };
        modules = [ ./hosts/Lappy/configuration.nix ];
      };
    };
}
