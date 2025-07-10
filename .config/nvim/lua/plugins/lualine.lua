return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = {
            section_separators = "|",
            component_separators = "|",
            globalstatus = true,
        },
        sections = {
            lualine_a = {},
            lualine_b = { { "filename", path = 1 } },
            lualine_c = { "branch", "diff" },
            lualine_x = { "diagnostics" },
            lualine_y = {},
            lualine_z = { "location" },
        },
    },
}
