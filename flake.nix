{
  description = "Adam's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs = { nixpkgs, ... }:
    {
      nixosConfigurations.Lappy = nixpkgs.lib.nixosSystem {
        modules = [ ./hosts/Lappy/configuration.nix ];
      };
    };
}
