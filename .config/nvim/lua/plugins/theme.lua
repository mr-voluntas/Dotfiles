vim.pack.add({
	{ src = "https://github.com/webhooked/kanso.nvim" },
})

require("kanso").setup({})

vim.cmd("colorscheme kanso-mist")
