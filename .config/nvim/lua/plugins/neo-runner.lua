vim.pack.add({ "https://github.com/theawakener0/NeoRunner" })

local status_ok, neorunner = pcall(require, "neorunner")

if status_ok then
	neorunner.setup({
		setup = {
			direction = "horizontal",
		},
	})
end

-- Run it
vim.keymap.set("n", "<leader>r", ":NeoRun<CR>", { desc = "Run C Code", silent = true })
