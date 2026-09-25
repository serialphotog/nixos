{ pkgs, nixpkgs-unstable, ... }:

let
  unstablePkgs = import nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
    config.allowUnfree = true;
  };
in
{
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    bat
    binutils
    binwalk
    gcc
    gdb
    gnumake
    jdk
    jre
    neovim
    obsidian
    tree-sitter
    unstablePkgs.codex
    unstablePkgs.opencode
    vscode
  ];

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "adam" ];
  };

  environment.etc."1password/custom_allowed_browsers" = {
    text = ''
      firefox
    '';
    mode = "0755";
  };
}
