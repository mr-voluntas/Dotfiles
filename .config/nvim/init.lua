require("config.options")
require("config.autocmds")
require("config.keymaps")

-- 1. Get the absolute path to your plugins folder
local plugins_path = vim.fn.stdpath("config") .. "/lua/plugins"

-- 2. Check if the folder exists, then read all files inside it
if vim.fn.isdirectory(plugins_path) == 1 then
	local files = vim.fn.readdir(plugins_path)

	for _, file in ipairs(files) do
		-- Only load files that end in .lua and aren't 'init.lua'
		if file:match("%.lua$") and file ~= "init.lua" then
			-- Convert "oil.lua" to "plugins.oil"
			local module = "plugins." .. file:gsub("%.lua$", "")

			-- Safely load the file
			local ok, err = pcall(require, module)
			if not ok then
				vim.notify("Error loading " .. module .. "\n" .. err, vim.log.levels.ERROR)
			end
		end
	end
end
