# Perform a clean deploy to nixvm.
nixvm-deploy:
    nix --extra-experimental-features 'nix-command flakes' run github:nix-community/nixos-anywhere -- --disko-mode disko --flake .#nixvm --target-host nixos@nixvm

# Perform a rebuild of nixvm.
nixvm-rebuild:
    nixos-rebuild switch --flake .#nixvm --target-host velen2077@nixvm --sudo