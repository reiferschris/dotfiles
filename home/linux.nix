{ config, pkgs, ... }: {
  programs = {
    zsh = {
      initExtraBeforeCompInit = ''
        eval "$(starship init zsh)"
      '';
    };
  };
}
