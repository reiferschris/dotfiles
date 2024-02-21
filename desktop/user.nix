{ config, pkgs, lib, ... }:
{
  # manage itself
  programs.home-manager.enable = true;
  manual.manpages.enable = true;
  # allow installation of fonts
  fonts.fontconfig.enable = true;

  home = {
    keyboard.layout = "eu";

    packages = with pkgs; [
      # fonts
      nerdfonts
      corefonts
      recursive

      # shell helper tools
      pcmanfm # filebrowser
      playerctl # media keys
      xclip # clipboard

      vlc # media player
      vscode # for debugging

      signal-desktop
      spotify
      postman
    ];
  };
}
