# NixOS: Tux Edition
{ pkgs, lib, ... }: {
  # nvidia my hatred
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.modesetting.enable = true; # We want users to see the boot animation

  system.nixos.label = "tux-edition";

  # Bootloader
  boot.loader.grub.memtest86.enable = lib.mkForce false;
  isoImage.efiSplashImage = lib.mkForce ./tux-wide.png;
  isoImage.splashImage = lib.mkForce ./tux-legacy.png;

  # Plymouth
  boot.plymouth.theme = "breeze";
  boot.plymouth.logo = ./tux-48.png;

  environment.systemPackages = lib.mkForce [];
  console.packages = lib.mkForce [];
  

  services.xserver.enable = lib.mkForce false;
  powerManagement.enable = lib.mkForce false;
  nix.enable = lib.mkForce false;

  users.extraUsers = {
    tux = {
      description = "my beloved";
      isNormalUser = true;
      extraGroups = [ "video" "audio" "network" "power" "users" "wheel" ];
    };
  };
  services.cage.enable = true;
  services.cage.program = "${pkgs.superTuxKart}/bin/supertuxkart";
  services.cage.user = "tux";
}
