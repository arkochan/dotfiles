-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local function fix_undefined_types()
  local diagnostics = vim.diagnostic.get(0) -- Get LSP diagnostics for current buffer
  local bufnr = vim.api.nvim_get_current_buf()

  for _, diagnostic in ipairs(diagnostics) do
    if diagnostic.message:match("undefined: (%w+)") then
      local type_name = diagnostic.message:match("undefined: (%w+)")
      local line, col = diagnostic.lnum, diagnostic.col

      -- Replace the type with "models.<Type>"
      vim.api.nvim_buf_set_text(bufnr, line, col, line, col + #type_name, { "models." .. type_name })
    end
  end
end

vim.api.nvim_create_user_command("FixModels", fix_undefined_types, {}) -- Create :FixModels command
