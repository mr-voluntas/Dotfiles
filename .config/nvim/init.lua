-----------------------------------------------------------
-- Bootstrap Lazy.nvim
-----------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-----------------------------------------------------------
-- Plugins
-----------------------------------------------------------
require("lazy").setup({
  -- LSP / Mason
  { "williamboman/mason.nvim",           config = function() require("mason").setup() end },
  { "williamboman/mason-lspconfig.nvim", config = function() require("mason-lspconfig").setup() end },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "lua_ls", "gopls", "clangd", "golangci-lint", "stylua", "goimports", "clang-format", "cpplint"
        },
      })
    end
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "go", "lua", "markdown" },
        highlight = { enable = true },
      })
    end,
  },

  -- LSP Config
  { "neovim/nvim-lspconfig",      lazy = false },

  -- Completion + Snippets
  { "hrsh7th/nvim-cmp",           lazy = false },
  { "hrsh7th/cmp-nvim-lsp",       lazy = false },
  { "hrsh7th/cmp-buffer",         lazy = false },
  { "hrsh7th/cmp-path",           lazy = false },
  { "saadparwaiz1/cmp_luasnip",   lazy = false },
  { "L3MON4D3/LuaSnip",           lazy = false,                                         dependencies = { "rafamadriz/friendly-snippets" } },

  -- UI / Utils
  { "akinsho/toggleterm.nvim",    config = function() require("toggleterm").setup() end },
  { "nvim-tree/nvim-web-devicons" },
  { "kvrohit/rasmus.nvim",        config = function() vim.cmd("colorscheme rasmus") end },
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.files").setup()
      require("mini.sessions").setup()
      require("mini.pick").setup()
      require("mini.statusline").setup()
      require("mini.tabline").setup()
      require("mini.jump").setup()
      require("mini.comment").setup()
      require("mini.surround").setup()
      require("mini.ai").setup()
      require("mini.trailspace").setup()
      require("mini.indentscope").setup()
    end
  },
})

-----------------------------------------------------------
-- nvim-cmp Setup
-----------------------------------------------------------
local luasnip = require("luasnip")
local cmp = require("cmp")
cmp.setup({
  snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
    { name = "luasnip" },
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  completion = { autocomplete = { cmp.TriggerEvent.TextChanged } },
})

-----------------------------------------------------------
-- LSP Setup + Diagnostics
-----------------------------------------------------------
local lspconfig = require("lspconfig")

local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, silent = true }

  -- LSP keymaps
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

  -- Format on save
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end
end

-- Setup LSP servers
lspconfig.lua_ls.setup({
  on_attach = on_attach,
  settings = {
    Lua = { runtime = { version = "LuaJIT" }, diagnostics = { globals = { "vim" } }, workspace = { library = vim.api.nvim_get_runtime_file("", true) }, telemetry = { enable = false } }
  }
})
lspconfig.gopls.setup({ on_attach = on_attach })
lspconfig.clangd.setup({ on_attach = on_attach })

-- Diagnostics signs
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Diagnostics config
vim.diagnostic.config({
  virtual_text = {
    prefix = '●',
    spacing = 2,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Diagnostics keymaps
local map = vim.keymap.set
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics list" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
  end,
})

-----------------------------------------------------------
-- General Options & Keymaps
-----------------------------------------------------------
vim.g.mapleader = " "
local opt = vim.opt
local indent = 2

opt.clipboard = "unnamedplus"
opt.backspace = { "eol", "start", "indent" }
opt.fileencoding = "utf-8"
opt.encoding = "utf-8"
opt.syntax = "enable"

opt.autoindent = true
opt.expandtab = true
opt.shiftwidth = indent
opt.smartindent = true
opt.softtabstop = indent
opt.tabstop = indent
opt.shiftround = true

opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.wildignore = opt.wildignore + { "*/node_modules/*", "*/.git/*", "*/vendor/*" }
opt.wildmenu = true

opt.cursorline = true
opt.laststatus = 2
opt.lazyredraw = true
opt.list = true
opt.winborder = "rounded"
opt.listchars = { tab = "┊ ", trail = "·", extends = "»", precedes = "«", nbsp = "×" }
opt.cmdheight = 1
opt.mouse = "a"
opt.number = true
opt.scrolloff = 20
opt.sidescrolloff = 3
opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.wrap = true
opt.termguicolors = true

opt.backup = false
opt.swapfile = false
opt.writebackup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"
opt.undolevels = 1000
opt.undoreload = 10000

opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess = opt.shortmess + { c = true }
opt.showmode = false

opt.history = 100
opt.redrawtime = 1500
opt.timeoutlen = 250
opt.ttimeoutlen = 10
opt.updatetime = 100
opt.foldmethod = "marker"
opt.foldlevel = 99

-- Keymaps
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

map("n", "<leader>v", ":vsplit<CR>")
map("n", "<leader>b", ":split<CR>")

map("n", "<C-Up>", ":resize +2<CR>")
map("n", "<C-Down>", ":resize -2<CR>")
map("n", "<C-Left>", ":vertical-resize +2<CR>")
map("n", "<C-Right>", ":vertical-resize -2<CR>")

map("n", "<Esc>", "<cmd>nohlsearch<CR>")

map("n", "<Left>", '<cmd>echo "Use h to move!!"<CR>')
map("n", "<Right>", '<cmd>echo "Use l to move!!"<CR>')
map("n", "<Up>", '<cmd>echo "Use k to move!!"<CR>')
map("n", "<Down>", '<cmd>echo "Use j to move!!"<CR>')

map("n", "<leader>ff", function() require("mini.pick").builtin.files() end)
map("n", "<leader>/", function() require("mini.pick").builtin.grep_live() end)
map("n", "<leader>pp", function() require("mini.sessions").select() end)
map("n", "<leader>bb", function() require("mini.pick").builtin.buffers() end)

-- Toggle Term
local toggleterm = require("toggleterm")

vim.keymap.set("n", "<leader>t", function()
  toggleterm.toggle(1, 20, vim.o.columns / 4, "float")
end, { desc = "Toggle small float terminal" })

vim.keymap.set("n", "<leader>T", function()
  toggleterm.toggle(2, 0, 0, "tab")
end, { desc = "Toggle full screen terminal" })

vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
