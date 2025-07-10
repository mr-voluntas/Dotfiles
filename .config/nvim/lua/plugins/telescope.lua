return {
    "nvim-telescope/telescope.nvim",
    keys = {
        {
            "<leader>so",
            function()
                require("telescope.builtin").find_files({ cwd = vim.fn.expand("~") })
            end,
            desc = "Find Files in Home",
            silent = true
        },
        { "<leader>sf",       "<cmd>Telescope find_files<CR>", desc = "Find Files", silent = true },
        { "<leader>sm",       "<cmd>Telescope man_pages<CR>",  desc = "Man Pages" },
        { "<leader>sg",       "<cmd>Telescope live_grep<CR>",  desc = "Live Grep" },
        { "<leader>sh",       "<cmd>Telescope help_tags<CR>",  desc = "Search Help" },
        { "<leader><leader>", "<cmd>Telescope buffers<CR>",    desc = "Buffers" },
    },
    opts = function()
        local actions = require("telescope.actions")
        return {
            defaults = {
                mappings = {
                    i = {
                        ["<C-x>"] = function(bufnr)
                            pcall(actions.delete_buffer, bufnr)
                        end,
                        ["<C-v>"] = function(bufnr)
                            pcall(actions.file_vsplit, bufnr)
                        end,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                    },
                },
                file_ignore_patterns = {
                    "target",
                    "node_modules",
                    "__pycache__",
                },
            },
            pickers = {
                find_files = { theme = "ivy" },
                live_grep = { theme = "ivy" },
                help_tags = { theme = "ivy" },
                man_pages = { theme = "ivy" },
                buffers = { theme = "ivy" },
            },
        }
    end,
}
