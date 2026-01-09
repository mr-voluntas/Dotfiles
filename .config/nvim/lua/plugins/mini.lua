vim.pack.add({
	{ src = "https://github.com/echasnovski/mini.nvim" },
})

require("mini.misc").setup()

------------------------------ FILES------------------------------
require("mini.files").setup({
	mappings = {
		close = "<Esc>",
		go_in_plus = "<Enter>",
	},
})

vim.keymap.set("n", "<leader>d", function()
	require("mini.files").open()
end)

------------------------------ PICK ------------------------------
require("mini.pick").setup({
	mappings = {
		move_down = "<C-j>",
		move_up = "<C-k>",
	},
	window = {
		config = {
			relative = "editor",
			width = math.floor(vim.o.columns),
			height = 15,
			border = "rounded",
		},
	},
})

vim.keymap.set("n", "<leader>f", function()
	require("mini.pick").builtin.files(nil, { source = { name = "Search Files" } })
end)

vim.keymap.set("n", "<leader>s", function()
	require("mini.pick").builtin.grep_live(nil, { source = { name = "Search Grep" } })
end)

vim.keymap.set("n", "<leader>h", function()
	require("mini.pick").builtin.help(nil, { source = { name = "Search Help" } })
end)

------------------------------ TABS ------------------------------
require("mini.tabline").setup({})
