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

  # Manually-installed to ~/Tools/ghidra rather than via nixpkgs; this just
  # gives it a KDE menu entry.
  environment.systemPackages = let
    ghidraLauncher = pkgs.makeDesktopItem {
      name = "ghidra";
      desktopName = "Ghidra";
      comment = "Software reverse engineering tool";
      exec = "/home/adam/Tools/ghidra/ghidraRun";
      icon = "/home/adam/Tools/ghidra/support/ghidra.ico";
      categories = [ "Development" "Security" ];
      terminal = false;
    };
  in with pkgs; [
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
    hugo
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

    ghidraLauncher
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
