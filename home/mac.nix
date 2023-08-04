{ config, pkgs, lib, ... }: {
  programs = {
    zsh = {
      initExtraBeforeCompInit =
      let shellenv = if pkgs.stdenv.hostPlatform.isAarch64 then "$(/opt/homebrew/bin/brew shellenv)" else "$(/usr/local/bin/brew shellenv)"; in
      ''
        eval ${shellenv}
        eval "$(starship init zsh)"
        eval "$(thefuck --alias)"
      '';
    };
  };
}
