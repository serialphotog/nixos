{
  description = "Adam's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    herdr.url = "github:herdrdev/herdr/v0.9.1";
  };

  outputs = { nixpkgs, herdr, ... }:
    {
      nixosConfigurations.Lappy = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit herdr; };
        modules = [ ./hosts/Lappy/configuration.nix ];
      };
    };
}
