-- Better window navigation
-- Control + h/j/k/l to move between any split/window
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move focus to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move focus to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move focus to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move focus to right window" })

-- Resize splits with arrows (Optional but very helpful with trees)
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", { silent = true })
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", { silent = true })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { silent = true })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { silent = true })

-- Cycle to the next buffer
vim.keymap.set("n", "<C-j>", ":bnext<CR>", { desc = "Next buffer", silent = true })

-- Cycle to the previous buffer
vim.keymap.set("n", "<C-k>", ":bprev<CR>", { desc = "Previous buffer", silent = true })

-- Save the current buffer
vim.keymap.set("n", "<C-w>", ":write<CR>", { desc = "Delete buffer", silent = true })

-- Close the current buffer
vim.keymap.set("n", "<C-d>", ":bdelete<CR>", { desc = "Delete buffer", silent = true })
