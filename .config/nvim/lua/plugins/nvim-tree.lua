vim.pack.add({
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
})
require("nvim-tree").setup({
	sync_root_with_cwd = true, -- This is the "magic" line
	respect_buf_cwd = false, -- Respect the CWD when opening
	update_focused_file = {
		enable = true, -- Auto-expand tree to the file you are editing
		update_root = false, -- Update tree root if you open a file outside CWD
	},
	renderer = {
		highlight_opened_files = "all", -- Highlights files you have open in a buffer
		highlight_git = true, -- Colors files based on git status (e.g. green for new)
		icons = {
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
			glyphs = {
				folder = {
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
				},
			},
		},
	},
})

vim.keymap.set("n", "<leader>t", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle Tree" })
