-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "json", "jsonc", "markdown" },
	callback = function()
		vim.opt.conceallevel = 0
	end,
})

-- Setup an autocmd to run the Lua code after the PersistenceLoadPost event
vim.api.nvim_create_autocmd("User", {
	pattern = "PersistenceLoadPost",
	callback = function()
		-- Store the current window
		local prev_win = vim.api.nvim_get_current_win()
		-- Open NeoTree
		vim.api.nvim_command("Neotree")
		-- Trigger a BufEnter event for NeoTree
		local neotree_buf = vim.fn.bufnr() -- Get the current buffer number (should be NeoTree)
		vim.api.nvim_command("doautocmd BufEnter " .. neotree_buf)
		-- Restore the previous window
		vim.api.nvim_set_current_win(prev_win)
		-- Create a notification
		require("notify")("Session Loaded", "info", { title = "Persistence" })
	end,
})
