{ config, pkgs, lib, ... }:
let
  user = "chris"; in
{
  imports = [
    ./dock
  ];

  homebrew = {
    enable = true;
    onActivation = {
      # "zap" removes manually installed brews and casks
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    brews = [
      "lima" # docker alternative
      # "skhd" # keybinding manager

      "ifstat" # network

      # borg
      "borgbackup"

      "languagetool"

      #Video
      "ffmpeg"

      # docker alternative
      "qemu"
      "colima"
      "docker"
      "docker-compose"
      "docker-buildx"
      "docker-machine"
      "docker-credential-helper"


      #devops
      { name = "ansible@9"; }
      "browserpass"


    ];
    casks = [
      # utilities
      "macfuse" # file system utilities
      "domzilla-caffeine"
      "eurkey" # keyboard layout

      # virtualization
      "utm" # virtual machines

      # communication
      "signal" # messenger
      "webex"
      "element"


      #Security
      "bitwarden"
      "gpg-suite"
      "yubico-authenticator"

      #Code
      "beekeeper-studio"
      "postman"
      "ghostty"
      "zed"

      #Browser     
      "chromium"
      "firefox"
      "qutebrowser"

      #Video- &Audiotools
      "mediainfo"

      #Others
      "logseq" #notes
      "inkscape"
      "drawio"
      "nextcloud" #for sync
      "obs" # stream / recoding software
      "spotify"
      "libreoffice"
      "raspberry-pi-imager"
      "shottr" # screenshot tool
      "the-unarchiver"
      "vscodium" # unbranded vscode
      "vlc" # media player
      "eul" # mac monitoring
      "vorta" #borg based backup tool

      #personal
      "prusaslicer" # slicer for my printer

    ];
    taps = [
      # custom
      "borgbackup/tap"
      "amar1729/formulae"
    ];
  };

  # It me
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  # Fully declarative dock using the latest from Nix Store from https://github.com/dustinlyons/nixos-config/blob/main/darwin/home-manager.nix
  local.dock.enable = true;
  local.dock.username = user;
  local.dock.entries = [
    { path = "/System/Applications/Mail.app/"; }
    { path = "/System/Applications/Calendar.app/"; }
    { path = "/Applications/Logseq.app/"; }
    { path = "/Applications/Bitwarden.app/"; }
    { path = "/Applications/Element.app/"; }
    { path = "/Applications/Ghostty.app/"; }
    { path = "/Applications/qutebrowser.app/"; }
    { path = "/Applications/Beekeeper Studio.app/"; }
    { path = "/Applications/Firefox.app/"; }
    { path = "/Applications/Spotify.app/"; }
    { path = "/Applications/Webex.app/"; }
    {
      path = "${config.users.users.${user}.home}/work/";
      section = "others";
      options = "--sort name --view grid --display folder";
    }
    {
      path = "${config.users.users.${user}.home}/Downloads";
      section = "others";
      options = "--sort dateadded --view grid --display stack";
    }
  ];
}
