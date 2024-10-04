local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Do things without affecting the registers
keymap.set("n", "x", '"_x')
keymap.set("n", "<Leader>p", '"0p')
keymap.set("n", "<Leader>P", '"0P')
keymap.set("v", "<Leader>p", '"0p')
keymap.set("n", "<Leader>c", '"_c')
keymap.set("n", "<Leader>C", '"_C')
keymap.set("v", "<Leader>c", '"_c')
keymap.set("v", "<Leader>C", '"_C')
keymap.set("n", "<Leader>d", '"_d')
keymap.set("n", "<Leader>D", '"_D')
keymap.set("v", "<Leader>d", '"_d')
keymap.set("v", "<Leader>D", '"_D')

-- Select all
-- keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
-- keymap.set("n", "te", ":tabedit")
-- keymap.set("n", "<tab>", ":tabnext<Return>", opts)
-- keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
-- Split window
-- keymap.set("n", "ss", ":split<Return>", opts)
-- keymap.set("n", "sv", ":vsplit<Return>", opts)
-- Move window
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Jump to tab left" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Jump to tab up" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Jump to tab down" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Jump to tab right" })
-- Resize window

-- keymap.set("n", "<C-Left>", "<C-w><", { desc = "resize window left", noremap = true })
-- keymap.set("n", "<C-Right>", "<C-w>>", { desc = "resize window right", noremap = true })
-- keymap.set("n", "<C-w><up>", "<C-w>-", { desc = "resize window up" })
-- keymap.set("n", "<C-w><down>", "<C-w>+", { desc = "resize window down" })

-- Diagnostics
keymap.set("n", "t", function()
	vim.diagnostic.goto_next()
end, opts)

keymap.set("n", "<leader>r", function()
	require("craftzdog.hsl").replaceHexWithHSL()
end)

keymap.set("n", "<leader>i", function()
	require("craftzdog.lsp").toggleInlayHints()
end)

keymap.set("n", "<C-n>", "<Cmd>Neotree toggle<cr>")

keymap.set("n", "<leader>cool", function()
	require("notify")("you are nice")
end, { desc = "you are niciefied" })
--keymap to show all keymaps throu telescope
keymap.set("n", "<leader>k", function()
	require("telescope.builtin").keymaps()
end, { desc = "Show all keymaps" })
