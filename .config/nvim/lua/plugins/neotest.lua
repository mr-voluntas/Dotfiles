return {
  "nvim-neotest/neotest",
  init = function()
    vim.keymap.set("n", "<leader>tt", function()
      vim.cmd 'lua require("neotest").run.run(vim.fn.expand "%")'
    end, { desc = "Neotest | Run File", silent = true })

    vim.keymap.set("n", "<leader>ta", function()
      vim.cmd 'lua require("neotest").run.run(vim.loop.cwd())'
    end, { desc = "Neotest | Run All Test Files", silent = true })

    vim.keymap.set("n", "<leader>tn", function()
      vim.cmd 'lua require("neotest").run.run()'
    end, { desc = "Neotest | Run Nearest", silent = true })

    -- vim.keymap.set("n", "<leader>Td", function()
    --   vim.cmd 'lua require("neotest").run.run { strategy = "dap" }'
    -- end, { desc = "Neotest | Run Dap", silent = true })

    vim.keymap.set("n", "<leader>ts", function()
      vim.cmd 'lua require("neotest").summary.toggle()'
    end, { desc = "Neotest | Toggle Summary", silent = true })

    vim.keymap.set("n", "<leader>to", function()
      vim.cmd 'lua require("neotest").output.open { enter = true, auto_close = true }'
    end, { desc = "Neotest | Show Output", silent = true })

    vim.keymap.set("n", "<leader>tp", function()
      vim.cmd 'lua require("neotest").output_panel.toggle()'
    end, { desc = "Neotest | Toggle Output Panel", silent = true })

    -- vim.keymap.set("n", "<leader>TS", function()
    --   vim.cmd 'lua require("neotest").run.stop()'
    -- end, { desc = "Neotest | Stop", silent = true })
  end,
  dependencies = {
    "nvim-neotest/neotest-python",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    -- {
    --   "fredrikaverpil/neotest-golang", -- Installation
    --   dependencies = {
    --     {
    --       "leoluz/nvim-dap-go",
    --       init = function()
    --         require("dap-go").setup()
    --       end,
    --     },
    --   },
    -- },
  },
  config = function()
    require("neotest").setup {
      adapters = {
        require "neotest-python" {
          runner = "pytest",
        },
        -- require "neotest-golang", -- Registration
      },
    }
  end,
}
