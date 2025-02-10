if true then
  return {}
end
return -- lazy.nvim:
{
  "jake-stewart/multicursor.nvim",
  event = "InsertEnter",
  config = function()
    local mc = require("multicursor-nvim")
    mc.setup()
    local set = vim.keymap.set

    -- Add or skip cursor above/below the main cursor.
    set({ "n", "v" }, "<up>", function()
      mc.lineAddCursor(-1)
    end)
    set({ "n", "v" }, "<down>", function()
      mc.lineAddCursor(1)
    end)
    set({ "n", "v" }, "<leader><up>", function()
      mc.lineSkipCursor(-1)
    end)
    set({ "n", "v" }, "<leader><down>", function()
      mc.lineSkipCursor(1)
    end)
    -- Add and remove cursors with control + left click.
    set("n", "<c-leftmouse>", mc.handleMouse)
    -- Customize how cursors look.
    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { link = "Cursor" })
    hl(0, "MultiCursorVisual", { link = "Visual" })
    hl(0, "MultiCursorSign", { link = "SignColumn" })
    hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
  end,
}
