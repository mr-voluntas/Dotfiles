return {
  "mr-voluntas/nvim-trackage",
  config = function()
    require("nvim-trackage").setup({
      time_record_file = vim.fn.expand("~") .. "/time_record_file.json",
    })
  end,
}
