local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Keymaps
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

keymap("n", "<leader>v", ":vsplit<CR>")
keymap("n", "<leader>b", ":split<CR>")

keymap("n", "<C-Up>", ":resize +2<CR>")
keymap("n", "<C-Down>", ":resize -2<CR>")
keymap("n", "<C-Left>", ":vertical-resize +2<CR>")
keymap("n", "<C-Right>", ":vertical-resize -2<CR>")

keymap("n", "<Esc>", "<cmd>nohlsearch<CR>")

keymap("n", "<Left>", '<cmd>echo "Use h to move!!"<CR>')
keymap("n", "<Right>", '<cmd>echo "Use l to move!!"<CR>')
keymap("n", "<Up>", '<cmd>echo "Use k to move!!"<CR>')
keymap("n", "<Down>", '<cmd>echo "Use j to move!!"<CR>')
