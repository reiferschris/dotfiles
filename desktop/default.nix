{ config, pkgs, lib, ... }: {
  imports = [
    ./wezterm.nix
    ./user.nix
    ./desktop.nix
  ];

  programs = {
    chromium = {
      enable = true;
      extensions = [
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      ];
    };
  };

  services = {
    flameshot.enable = true;
    redshift = {
      enable = true;
      tray = true;
      # germany -> kölle
      latitude = "50.935173";
      longitude = "6.953101";
      settings.redshift = {
        brightness-day = "1";
        brightness-night = "0.8";
      };
      temperature = {
        night = 3700;
        day = 5500;
      };
    };
  };
}
