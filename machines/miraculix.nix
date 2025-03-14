{ config, pkgs, lib, ... }: {
  environment = {
    systemPackages = with pkgs; [ ];
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  programs = {
    zsh.enable = true;
  };

  networking = {
    hostName = "miraculix";
    knownNetworkServices = [ "Wi-Fi" ];
    # disabled in favor of my pi-hole at home
  };

  fonts = {
    # recommended on screens larger than fullhd
    # optimizeForVeryHighDPI = true;
    packages = with pkgs; [
      nerd-fonts.fira-code
    ];
  };

  system = {
    defaults = {
      NSGlobalDomain = {
        AppleFontSmoothing = 0;
        NSAutomaticSpellingCorrectionEnabled = false;
      };
      dock = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.0;
        launchanim = false;
      };
    };
    keyboard = {
      enableKeyMapping = true;
    };
  };
}
