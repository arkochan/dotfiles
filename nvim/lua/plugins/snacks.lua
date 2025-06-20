return {
  {
    "folke/snacks.nvim",
    lazy = false,
    opts = {
      -- quickfile = { enabled = true },
      -- rename = { enabled = true },
      indent = {
        enabled = false,
        indent = {
          char = "│",
          hl = hl_colors,
        },
      },
      scope = {
        enabled = false, -- enable highlighting the current scope
        priority = 200,
        char = {
          corner_top = "x",
          corner_bottom = "└",
          -- corner_top = "╭",
          -- corner_bottom = "╰",
          horizontal = "─",
          vertical = "│",
          arrow = "x",
        },
        underline = true, -- underline the start of the scope
        only_current = false, -- only show scope in the current window
        hl = hl_colors,
      },

      chunk = {
        -- when enabled, scopes will be rendered as chunks, except for the
        -- top-level scope which will be rendered as a scope.
        enabled = false,
        -- only show chunk scopes in the current window
        only_current = true,
        priority = 200,
        hl = hl_colors,
        char = {
          corner_top = "x",
          corner_bottom = "└",
          -- corner_top = "╭",
          -- corner_bottom = "╰",
          horizontal = "─",
          vertical = "│",
          arrow = ">",
        },
      },
    },
  },
}
