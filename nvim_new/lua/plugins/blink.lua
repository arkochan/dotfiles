return {
  {
    "Saghen/blink.cmp",
    -- enabled = false,

    opts = {
      keymap = {
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        -- ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = {
          -- function(cmp)
          --   return cmp.accept()
          -- end,
          "accept",
          "snippet_forward",
          "fallback",
        },
        ["<C-Tab>"] = {
          -- function(cmp)
          --   return cmp.select_next()
          -- end,
          "select_next",
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = {
          -- function(cmp)
          --   return cmp.select_prev()
          -- end,
          "select_prev",
          "snippet_backward",
          "fallback",
        },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-up>"] = { "scroll_documentation_up", "fallback" },
        ["<C-down>"] = { "scroll_documentation_down", "fallback" },
      },
    },
  },
}
