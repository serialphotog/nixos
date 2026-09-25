# NixOS configuration

This is my very work-in-progress NixOS configuration. This is meant to be paired with my [dotfiles](https://github.com/serialphotog/dotfiles).

# Apply Configuration

```sh
sudo nixos-rebuild switch --flake /home/adam/nix#Lappy
```

Update pinned inputs with:

```sh
cd /home/adam/nix
nix flake update
```

## Updates

```bash
cd /home/adam/nix
nix flake update nixpkgs-unstable
sudo nixos-rebuild switch --flake .#Lappy
```

# Cleanup Old Generations

```bash
sudo nix-collect-garbage --delete-old
sudo nix-store --optimise
```