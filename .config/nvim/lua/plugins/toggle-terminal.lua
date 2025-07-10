return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {},
    config = function()
      require("toggleterm").setup{
        open_mapping = [[<c-\>]],
        shade_terminals = true,
        direction = "horizontal",
        size = function(term)
          if term.direction == "horizontal" then
            return vim.o.lines * 0.4
          end
          return 20
        end,
      }

      local Terminal = require("toggleterm.terminal").Terminal

      -- Horizontal terminal (40% height)
      local horizontal_term = Terminal:new({
        direction = "horizontal",
        size = vim.o.lines * 0.4,
        hidden = true
      })

      -- Toggle horizontal terminal with <leader>th
      vim.keymap.set("n", "<leader>th", function()
        horizontal_term:toggle()
      end, { desc = "Toggle 40% horizontal terminal" })

      -- Fullscreen floating terminal
      local fullscreen_term = Terminal:new({
        direction = "float",
        float_opts = {
          border = "curved",
          width = function() return vim.o.columns end,
          height = function() return vim.o.lines end,
        },
        hidden = true
      })

      -- Toggle fullscreen terminal with <leader>tf
      vim.keymap.set("n", "<leader>tf", function()
        fullscreen_term:toggle()
      end, { desc = "Toggle fullscreen terminal" })

      -- Double ESC to close the terminal
      vim.api.nvim_set_keymap("t", "<Esc><Esc>", "<C-\\><C-N>:lua require('toggleterm').toggle()<CR>", { noremap = true, silent = true })
    end
  }
}
