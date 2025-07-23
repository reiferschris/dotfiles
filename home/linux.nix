{ config, pkgs, ... }: {
  programs = {
    zsh = {
      initConten = ''
        eval "$(starship init zsh)"
      '';
    };
  };
}
