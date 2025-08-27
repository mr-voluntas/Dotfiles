return {
  "ThePrimeagen/harpoon",
  init = function()
    vim.keymap.set("n", "<leader>ha", function()
      require("harpoon"):list():add()
      vim.notify("   Marked file", vim.log.levels.INFO, { title = "Harpoon" })
    end, { desc = "Harpoon | Add Mark" })

    vim.keymap.set("n", "<leader>hr", function()
      require("harpoon"):list():remove()
      vim.notify("   Unmarked file", vim.log.levels.INFO, { title = "Harpoon" })
    end, { desc = "Harpoon | Remove Mark" })

    vim.keymap.set("n", "<leader>hh", function()
      require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
    end, { desc = "Harpoon | Menu" })

    vim.keymap.set("n", "<leader>h1", function()
      require("harpoon"):list():select(1)
    end, { desc = "Harpoon | File 1" })

    vim.keymap.set("n", "<leader>h2", function()
      require("harpoon"):list():select(2)
    end, { desc = "Harpoon | File 2" })

    vim.keymap.set("n", "<leader>h3", function()
      require("harpoon"):list():select(3)
    end, { desc = "Harpoon | File 3" })

    vim.keymap.set("n", "<leader>h4", function()
      require("harpoon"):list():select(4)
    end, { desc = "Harpoon | File 4" })

    vim.keymap.set("n", "<leader>h5", function()
      require("harpoon"):list():select(5)
    end, { desc = "Harpoon | File 5" })
  end,
  branch = "harpoon2",
  opts = {},
}
