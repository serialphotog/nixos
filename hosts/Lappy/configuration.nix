{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/base.nix
    ../../modules/nixos/desktop-plasma.nix
    ../../modules/nixos/audio.nix
    ../../modules/nixos/applications.nix
    ../../modules/nixos/users/adam.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.graphics.enable = true;
  services.power-profiles-daemon.enable = true;
  services.thermald.enable = true;

  networking.hostName = "Lappy";

  system.stateVersion = "26.05";
}
