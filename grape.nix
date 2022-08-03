# Proof grapejuice is by retards!
{ pkgs, lib, ... }: {
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = lib.mkForce true;
  hardware.nvidia.modesetting.enable = true;

  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  environment.systemPackages = [
    pkgs.grapejuice
  ];
}
