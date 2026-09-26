{ pkgs, herdr, ... }:

{
  # Patch the Obsidian launcher to fix missing icon.
  nixpkgs.overlays = [
    (final: prev: {
      obsidian = prev.obsidian.overrideAttrs (old: {
        postFixup = ''
          ${old.postFixup or ""}
          substituteInPlace $out/share/applications/obsidian.desktop \
            --replace-fail "StartupWMClass=md.Obsidian" "StartupWMClass=md.obsidian.Obsidian"
        '';
      });
    })
  ];

  programs.firefox.enable = true;
  programs.wireshark.enable = true;

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
