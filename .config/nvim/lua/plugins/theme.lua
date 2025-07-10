return {
  "gbprod/nord.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local ok, nord = pcall(require, "nord")
    if ok and nord and type(nord.setup) == "function" then
      nord.setup({})
    end
    vim.cmd.colorscheme("nord")
  end,
}
