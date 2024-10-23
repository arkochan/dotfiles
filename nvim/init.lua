if vim.loader then
	vim.loader.enable()
end

_G.dd = function(...)
	require("util.debug").dump(...)
end
vim.print = _G.dd

-- function to prompt for input
local function input(prompt)
	local result = vim.fn.input(prompt)
	return result
end

-- function to add plugin
local function add_plugin(filename)
	-- prompt for the plugin object
	local plugin_object = input("enter the plugin object: ")

	-- construct the full path to the file
	local file_path = vim.fn.expand("$home/.config/nvim/lua/plugins/" .. filename .. ".lua")

	-- read the existing file contents
	local lines = {}
	local file = io.open(file_path, "r")
	if file then
		for line in file:lines() do
			table.insert(lines, line)
		end
		file:close()
	end

	-- find the position to insert the new plugin object
	local insert_pos = #lines
	for i = #lines, 1, -1 do
		if lines[i]:match("^%s*}") then
			insert_pos = i - 1
			break
		end
	end

	-- insert the new plugin object
	table.insert(lines, insert_pos + 1, "  " .. plugin_object .. ",")

	-- write the updated contents back to the file
	file = io.open(file_path, "w")
	for _, line in ipairs(lines) do
		if file then
			file:write(line .. "\n")
		end
	end
	if file then
		file:close()
	end
	print("plugin added successfully!")
end

-- define the custom command
vim.api.nvim_create_user_command("Addplugin", function(opts)
	add_plugin(opts.args)
end, { nargs = 1 })
--Set colorscheme repo name
vim.g.colorscheme_name = "oxocarbon"
vim.g.colorscheme_repo = "nyoom-engineering/oxocarbon.nvim"
require("config.lazy")
