{ pkgs, nixpkgs-unstable, herdr, ... }:

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
    btop
    claude-code
    cloc
    cmake
    fd
    file
    fzf
    gcc
    gdb
    ghostty
    gnumake
    herdr.packages.${pkgs.stdenv.hostPlatform.system}.default
    jdk
    jre
    lazygit
    neovim
    nmap
    obsidian
    resources
    ripgrep
    spotify
    tor-browser
    tree-sitter
    vscode
    wireshark
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
