return {
	"williamboman/mason.nvim",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"mason-org/mason-lspconfig.nvim",
	},
	config = function()
		-- Enable mason
		require("mason").setup({
			ui = {
				border = "rounded",
			},
		})

		-- Install formatters, and linters
		require("mason-tool-installer").setup({
			ensure_installed = {
				"lua_ls",
				"jdtls",
				-- "bashls",
				-- "dockerls",
				-- "grammarly",
				-- "yamlls",

				-- "stylua", -- Lua formatter
				-- "shellcheck", -- Shell script linter
				-- "shfmt", -- Shell script formatter
			},
		})
	end,
}
