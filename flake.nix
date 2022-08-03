{
  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
  outputs = { self, nixpkgs, ... }: {
    packages.x86_64-linux.grapejuice = (nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-plasma5.nix"
        ./grape.nix
      ];
    }).config.system.build.isoImage;
    packages.x86_64-linux.tux = (nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-base.nix"
        ./tux.nix
      ];
    }).config.system.build.isoImage;
  };
}
