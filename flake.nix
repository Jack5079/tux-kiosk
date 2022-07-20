{
  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
  outputs = { self, nixpkgs, ... }: {
    defaultPackage.x86_64-linux = (nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-plasma5.nix"
        "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-base.nix"
        # ./configuration.nix
        ./tux.nix
      ];
    }).config.system.build.isoImage;
  };
}
