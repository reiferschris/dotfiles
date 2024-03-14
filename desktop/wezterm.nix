{ config, pkgs, lib, ... }: {
  programs.wezterm= {
    enable = true;
    extraConfig = '' 

      wezterm.on('user-var-changed', function(window, pane, name, value)
        local overrides = window:get_config_overrides() or {}
        if name == "ZEN_MODE" then
            local incremental = value:find("+")
            local number_value = tonumber(value)
            if incremental ~= nil then
                while (number_value > 0) do
                    window:perform_action(wezterm.action.IncreaseFontSize, pane)
                    number_value = number_value - 1
                end
                overrides.enable_tab_bar = false
            elseif number_value < 0 then
                window:perform_action(wezterm.action.ResetFontSize, pane)
                overrides.font_size = nil
                overrides.enable_tab_bar = true
            else
                overrides.font_size = number_value
                overrides.enable_tab_bar = false
            end
        end
        window:set_config_overrides(overrides)
      end)
      
      return {
        font = wezterm.font("FiraCode Nerd Font Mono"),
        font_size = 16.0,
        color_scheme = "Catppuccin Frappe",
        hide_tab_bar_if_only_one_tab = true,
--        default_prog = { "zsh", "--login", "-c", "tmux attach -t dev || tmux new -s dev" },
        keys = {
          {key="n", mods="SHIFT|CTRL", action="ToggleFullScreen"},
--          {key="9", mods="ALT", action="act.ShowLauncherArgs {flags='FUZZY|WORKSPACES'}},
        }
      }
      '';
  };
}
