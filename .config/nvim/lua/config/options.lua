local opt = vim.opt
vim.g.mapleader = " "
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.tabstop = 2
opt.softtabstop = 2
opt.expandtab = true
opt.shiftwidth = 2
opt.pumheight = 10 -- Smaller completion menu
opt.updatetime = 200 -- Faster trigger for CursorHold (LSP highlights)
opt.completeopt = "menu,menuone,noselect,fuzzy"
opt.cursorline = true
opt.termguicolors = true -- Required for modern themes
opt.background = "dark" -- Ensure Neovim knows to use the "dark" variants of colors
opt.showmode = false -- We already have the statusline for this
opt.laststatus = 3 -- Global statusline (one bar across all splits)
opt.fillchars = { eob = " " } -- Hide the '~' on empty lines
opt.clipboard = "" -- Only use system clipboard when explicitly asked
opt.textwidth = 100 -- Only use system clipboard when explicitly asked

-- Helper to get the current Git branch
local function get_git_branch()
	-- Try to get branch from gitsigns or similar, fallback to shell
	local branch = vim.b.gitsigns_head or vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null"):gsub("\n", "")
	if branch == "" or branch:match("fatal") then
		return ""
	end
	return "  " .. branch .. " "
end

function _G.statusline()
	local branch = get_git_branch()
	local file_path = " %f"
	local modified = " %m"
	local align = "%="
	local line_col = " %l:%c "
	local percentage = " %p%% "

	-- Get active LSP client name
	local lsp_msg = "No LSP"
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if next(clients) ~= nil then
		lsp_msg = clients[1].name
	end

	-- Format: [Branch] [Path] [Modified] [Right-Align] [LSP] [Line:Col] [Percentage]
	return string.format("%s  %s%s%s[%s] %s%s", file_path, branch, modified, align, lsp_msg, line_col, percentage)
end

vim.opt.statusline = "%!v:lua.statusline()"

vim.opt.fillchars = {
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vert = "┃",
	vertleft = "┫",
	vertright = "┣",
	verthoriz = "╋",
}
