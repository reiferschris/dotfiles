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
    };
    brews = [
      "lima" # docker alternative
      "skhd" # keybinding manager


      # broken nix builds
      "yabai" # tiling window manager

      # sketchybar
      "sketchybar" # macos bar alternative
      "ifstat" # network

      # borg
      "borgbackup"

      "spotify-tui"

      "languagetool"
      
      #Video
      "ffmpeg"

      # docker alternative
      "qemu"

      
      #devops
      "ansible"

    ];
    casks = [
      # utilities
      "browserosaurus" # choose browser on each link
      "macfuse" # file system utilities
      "hammerspoon" # lua scripting engine

      # virtualization
      {
        name = "podman-desktop";
        greedy = true;
      }
      "utm" # virtual machines

      # communication
      "signal" # messenger
      "rocket-chat"
      "thunderbird"
      "cisco-jabber"


      #Security
      "bitwarden"
      "wireshark" # network sniffer
      "gpg-suite"

      #Code
      "meld" # folder differ
      "postman"
      "wezterm"

      #Browser     
      "chromium"
      "firefox"

      #Videotools
      "mediainfo"

      #devops
      "rancher"

      #Others
      "logseq" #notes
      "inkscape"
      "drawio"
      "owncloud" #for sync
      "obs" # stream / recoding software
      "spotify"
      "libreoffice"
      "vial"
      "raspberry-pi-imager"
      "shottr" # screenshot tool
      "the-unarchiver"
      "vscodium" # unbranded vscode
      "vlc" # media player
      "eul" # mac monitoring
      "qmk-toolbox" # flashing keyboard
      "kap" # screen recorder software
      "sf-symbols" # patched font for sketchybar
      "prusaslicer" # slicer for my printer
      "min" # minimal browser
      "time-out" # blurs screen every x mins
      "vorta" #borg based backup tool
    ];
    taps = [
      # default
      "homebrew/bundle"
      "homebrew/cask"
      "homebrew/cask-drivers"
      "homebrew/cask-fonts"
      "homebrew/core"
      "homebrew/services"
      # custom
      "koekeishiya/formulae" # yabai
      "FelixKratz/formulae" # sketchybar
      "borgbackup/tap"
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
    { path = "/System/Applications/Utilities/Terminal.app/"; }
    { path = "/Applications/VSCodium.app/"; }
    { path = "/Applications/Logseq.app/"; }
    { path = "/Applications/Bitwarden.app/"; }  
    { path = "/Applications/Rocket.Chat.app/"; }
    { path = "${pkgs.alacritty}/Applications/Alacritty.app/"; }
    { path = "${pkgs.wezterm}/Applications/Wezterm.app/"; }
    { path = "/Applications/Firefox.app/"; }
    { path = "/Applications/min.app/"; }
    {
      path = "${config.users.users.${user}.home}/.local/share/";
      section = "others";
      options = "--sort name --view grid --display folder";
    }
    {
      path = "${config.users.users.${user}.home}/Downloads";
      section = "others";
      options = "--sort name --view grid --display stack";
    }
  ];
}
