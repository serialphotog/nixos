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
    brave
    claude-code
    gcc
    gdb
    ghostty
    gnumake
    jdk
    jre
    neovim
    obsidian
    spotify
    tree-sitter
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
      brave
    '';
    mode = "0755";
  };
}
