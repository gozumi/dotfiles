-- lualine
require("lualine").setup({
    options = {
        path = 1,
        theme = "rose-pine",
        icons_enabled = true,
        component_separators = "|",
        section_separators = "",
        disabled_filetypes = {
            statusline = { "NvimTree" },
        },
    },
})

