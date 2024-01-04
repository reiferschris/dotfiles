return {
require("catppuccin").setup({
    integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        telescope = true,
        notify = false,
        indent_blankline = {
          enabled = true,
          scope_color = "rosewater", -- catppuccin color (eg. `lavender`) Default: text
          colored_indent_levels = false,
        which_key = true,
        },
        },
    }),
}
