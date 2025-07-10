return {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
        -- mini.move
        require("mini.move").setup({
            mappings = {
                left = "<C-h>",
                right = "<C-l>",
                down = "<C-j>",
                up = "<C-k>",
            },
        })

        -- mini.ai
        require("mini.ai").setup({ n_lines = 500 })

        -- mini.surround
        require("mini.surround").setup()
    end,
}
