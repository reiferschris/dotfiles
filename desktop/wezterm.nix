{ config, pkgs, lib, ... }: {
  programs.wezterm= {
    enable = true;
    extraConfig = '' 
      return {
        font = wezterm.font("FiraCode Nerd Font Mono"),
        font_size = 16.0,
        color_scheme = "Catppuccin Frappe",
        hide_tab_bar_if_only_one_tab = true,
--        default_prog = { "zsh", "--login", "-c", "tmux attach -t dev || tmux new -s dev" },
        keys = {
          {key="n", mods="SHIFT|CTRL", action="ToggleFullScreen"},
        }
      }
      '';
  };
}
