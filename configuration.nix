# NixOS: Tux Edition
{ pkgs, lib, ... }: {
  # nvidia my hatred
  nixpkgs.config.allowUnfree = true;
  # services.xserver.videoDrivers = [ "nvidia" ];
  # hardware.nvidia.modesetting.enable = true; # We want users to see the boot animation

  system.nixos.label = "tux-edition";

  # Bootloader
  boot.loader.grub.memtest86.enable = lib.mkForce false;
  isoImage.efiSplashImage = lib.mkForce ./tux-wide.png;
  isoImage.splashImage = lib.mkForce ./tux-legacy.png;

  # Plymouth
  boot.plymouth.theme = "breeze";
  boot.plymouth.logo = ./tux-48.png;

  environment.defaultPackages = lib.mkForce [ ];
  console.packages = lib.mkForce [ ];
  fonts.enableDefaultPackages = false;
  fonts.packages = lib.mkForce [ ];

  services.xserver.excludePackages = with pkgs; [
    xorg.xorgserver.out
    xorg.xrandr
    xorg.xrdb
    xorg.setxkbmap
    xorg.iceauth # required for KDE applications (it's called by dcopserver)
    xorg.xlsclients
    xorg.xset
    xorg.xsetroot
    xorg.xinput
    xorg.xprop
    xorg.xauth
    pkgs.xterm
    pkgs.xdg-utils
    xorg.xf86inputevdev.out # get evdev.4 man page
    pkgs.nixos-icons # needed for gnome and pantheon about dialog, nixos-manual and maybe more
  ];
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
  services.cage.program = lib.getExe pkgs.superTuxKart;
  services.cage.user = "tux";
}
