{ pkgs, ... }:

{
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    binutils
    binwalk
    codex
    gcc
    gdb
    gnumake
    jdk
    jre
    neovim
    obsidian
    opencode
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
    '';
    mode = "0755";
  };
}
