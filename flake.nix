{
  description = "Adam's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    herdr.url = "github:herdrdev/herdr/v0.9.1";
  };

  outputs = { nixpkgs, nixpkgs-unstable, herdr, ... }:
    {
      nixosConfigurations.Lappy = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit nixpkgs-unstable herdr; };
        modules = [ ./hosts/Lappy/configuration.nix ];
      };
    };
}
