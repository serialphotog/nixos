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

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vpl-gpu-rt
    ];
  };
  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";
  hardware.system76.enableAll = true;
  services.power-profiles-daemon.enable = false;
  services.thermald.enable = true;

  networking.hostName = "Lappy";

  system.stateVersion = "26.05";
}
