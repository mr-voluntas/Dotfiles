local map = vim.keymap.set

-- Jump between windows
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Vertical split
map("n", "<leader>v", function()
    vim.cmd(":vsplit")
end)

-- Resize bigger vertically
map("n", "<C-up>", function()
    vim.cmd(":resize +2")
end)

-- Resize smaller vertically
map("n", "<C-down>", function()
    vim.cmd(":resize -2")
end)

-- Resize bigger horizontally
map("n", "<C-left>", function()
    vim.cmd(":vertical-resize +2")
end)

-- Resize smaller horizontally
map("n", "<C-right>", function()
    vim.cmd(":vertical-resize -2")
end)

-- Clear highlights on search when pressing <Esc> in normal mode
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Disable arrow keys in normal mode
map("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
map("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
map("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
map("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')


-- Open config file
map("n", "<leader>sc", function()
    require('telescope.builtin').find_files({ cwd = "~/dotfiles/", hidden = true })
end, { desc = "Edit init.lua" })
