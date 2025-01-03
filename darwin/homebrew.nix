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
      "skhd" # keybinding manager


      # broken nix builds
      "yabai" # tiling window manager

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
      "docker-machine"
      "docker-credential-helper"


      #devops
      "ansible"
      "browserpass"

      #misc
      "iamb"

    ];
    casks = [
      # utilities
      "macfuse" # file system utilities
      "domzilla-caffeine"

      # virtualization
      "utm" # virtual machines

      # communication
      "signal" # messenger
      "rocket-chat"
      "thunderbird"
      "webex"


      #Security
      "bitwarden"
      "wireshark" # network sniffer
      "gpg-suite"
      "yubico-yubikey-manager"

      #Code
      "beekeeper-studio"
      "postman"
      "wezterm"

      #Browser     
      "chromium"
      "firefox"
      "qutebrowser"

      #Video- &Audiotools
      "mediainfo"
      "background-music" #use system-audio-output as input for e.g. screenrecordings

      #Others
      "logseq" #notes
      "inkscape"
      "drawio"
      "owncloud" #for sync
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
      "ubersicht"

      #personal
      "prusaslicer" # slicer for my printer
      "qmk-toolbox" # flashing keyboard
      "vial"

    ];
    taps = [
      # default
      "homebrew/bundle"
      # "homebrew/cask"
      "homebrew/cask-fonts"
      # "homebrew/core"
      "homebrew/services"
      # custom
      "koekeishiya/formulae" # yabai
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
  local.dock.entries = [
    { path = "/Applications/Thunderbird.app/"; }
    { path = "/Applications/Logseq.app/"; }
    { path = "/Applications/Bitwarden.app/"; }
    { path = "/Applications/Rocket.Chat.app/"; }
    { path = "${pkgs.wezterm}/Applications/Wezterm.app/"; }
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
