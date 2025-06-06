{ config, pkgs, lib, ... }: {

  home.file.ghostty = {
    target = ".config/ghostty/config";
    text = ''
      theme = catppuccin-macchiato
    '';
  };
}
