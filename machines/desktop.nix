{ config, pkgs, lib, ... }: {
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  hardware.pulseaudio.enable = false;
}
