return {
  "lukas-reineke/indent-blankline.nvim",
  config = function()
    local highlight = {
      "RainbowRed",
      "RainbowYellow",
      "RainbowBlue",
      "RainbowOrange",
      "RainbowGreen",
      "RainbowViolet",
      "RainbowCyan",
      "RainbowWhite",
    }
    local hooks = require("ibl.hooks")
    -- create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#FF5555" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#F1FA8C" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#BD93F9" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#FFB86C" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#50FA7B" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#FF79C6" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#8BE9FD" })
      vim.api.nvim_set_hl(0, "RainbowWhite", { fg = "#FFFFFF" })
    end)

    require("ibl").setup({
      indent = { highlight = highlight },
      scope = { highlight = "RainbowWhite" },
    })
  end,
}
