vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/Saghen/blink.cmp" },
})

-- 1. Mason & Tools Setup
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "clangd", "gopls" },
})

-- 2. Snippets
require("luasnip.loaders.from_vscode").lazy_load()

local border = "rounded"

-- 3. Blink.cmp Setup
require("blink.cmp").setup({
	snippets = { preset = "luasnip" },
	signature = { enabled = true, window = { border = border } },

	sources = {
		-- 1. Add 'snippets' back into the list
		default = { "lsp", "path", "snippets", "buffer" },

		-- 2. Prioritize LSP over Friendly-Snippets
		providers = {
			snippets = { score_offset = -3 },
			lsp = { score_offset = 3 },
		},
	},

	completion = {
		menu = {
			border = border,
			draw = {
				-- 3. Added "source_name" here so you can see [LSP] or [Snippet]
				columns = {
					{ "label", "label_description", gap = 1 },
					{ "kind_icon", "source_name" },
				},
			},
		},
		documentation = {
			auto_show = true,
			window = { border = border },
		},
	},

	keymap = {
		preset = "none",
		["<CR>"] = { "accept", "fallback" },
		["<C-j>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<Tab>"] = { "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },
	},

	fuzzy = {
		implementation = "lua",
		prebuilt_binaries = { download = true },
	},
})
-- 4. LSP Configurations
local caps = require("blink.cmp").get_lsp_capabilities()

-- Lua: Optimized for snippets and clean diagnostics
vim.lsp.config("lua_ls", {
	capabilities = caps,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim", "require" } },
			workspace = { library = vim.api.nvim_get_runtime_file("", true) },
			completion = { callSnippet = "Replace" },
		},
	},
})

vim.lsp.config("clangd", { capabilities = caps })
vim.lsp.config("gopls", { capabilities = caps })

-- Enable servers
vim.lsp.enable({ "lua_ls", "clangd", "gopls" })

-- 5. Diagnostics Configuration
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = { border = "rounded", source = "always" },
})

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
vim.keymap.set("n", "[d", vim.diagnostic.get_prev, { desc = "Go to previous error" })
vim.keymap.set("n", "]d", vim.diagnostic.get_next, { desc = "Go to next error" })

-- 6. Global LSP Keymaps
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local opts = { buffer = args.buf }

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end, opts)

		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

		vim.keymap.set("i", "<C-s", function()
			vim.lsp.buf.signature_help({ border = "rounded" })
		end, opts)
	end,
})
