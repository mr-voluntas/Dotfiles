-- LSP Buffer local settings (Completion, Highlights, Keymaps)

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		client.server_capabilities.semanticTokensProvider = nil
	end,
})

-- Formatting on Save
vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = true }),
	callback = function()
		vim.lsp.buf.format({ async = false, timeout_ms = 1000 })
	end,
})

-- Highlighting and UI behaviors
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ timeout = 200 })
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(args.buf) then
			vim.api.nvim_win_set_cursor(0, mark)
			vim.schedule(function()
				vim.cmd("normal! zz")
			end)
		end
	end,
})

-- Window and FileType behaviors
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	callback = function()
		vim.cmd("wincmd L")
		vim.keymap.set("n", "<Esc>", "<cmd>q<cr>", { buffer = true, silent = true })
	end,
})

vim.api.nvim_create_autocmd("VimResized", { command = "wincmd =" })

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- Active window cursorline toggle
local cursor_grp = vim.api.nvim_create_augroup("active_cursorline", { clear = true })
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = cursor_grp,
	callback = function()
		vim.opt_local.cursorline = true
	end,
})
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	group = cursor_grp,
	callback = function()
		vim.opt_local.cursorline = false
	end,
})

-- close tree is last window
vim.api.nvim_create_autocmd("QuitPre", {
	callback = function()
		local tree_wins = {}
		local floating_wins = {}
		local wins = vim.api.nvim_list_wins()
		for _, w in ipairs(wins) do
			local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
			if bufname:match("NvimTree_") ~= nil then
				table.insert(tree_wins, w)
			end
			if vim.api.nvim_win_get_config(w).relative ~= "" then
				table.insert(floating_wins, w)
			end
		end
		if 1 == #wins - #floating_wins - #tree_wins then
			for _, w in ipairs(tree_wins) do
				vim.api.nvim_win_close(w, true)
			end
		end
	end,
})

local number_toggle_group = vim.api.nvim_create_augroup("NumberToggle", { clear = true })

-- When entering Insert mode, turn on Relative numbers
vim.api.nvim_create_autocmd("InsertEnter", {
	group = number_toggle_group,
	callback = function()
		vim.opt.relativenumber = true
	end,
})

-- When leaving Insert mode (returning to Normal), turn off Relative numbers
vim.api.nvim_create_autocmd("InsertLeave", {
	group = number_toggle_group,
	callback = function()
		vim.opt.relativenumber = false
	end,
})

vim.keymap.set("n", "<leader>cd", function()
	local entry = MiniFiles.get_fs_entry()
	local target_dir

	if entry ~= nil then
		target_dir = vim.fn.isdirectory(entry.path) == 1 and entry.path or vim.fn.fnamemodify(entry.path, ":h")
	else
		local state = MiniFiles.get_explorer_state()
		if state and state.focused_path then
			target_dir = vim.fn.isdirectory(state.focused_path) == 1 and state.focused_path
				or vim.fn.fnamemodify(state.focused_path, ":h")
		end
	end

	if target_dir then
		vim.fn.chdir(target_dir)
		print("New PWD: " .. vim.fn.getcwd())
	else
		print("Could not find a valid path to CD into")
	end
end, { desc = "Set CWD from MiniFiles" })
