-- Lua
return {
    {
      "folke/zen-mode.nvim",
      opts = {
        plugins = {
            wezterm = {
              enabled = true,
              -- can be either an absolute font size or the number of incremental steps
              font = "+4", -- (10% increase per step)
            },        -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
              }
        }
    }
}
