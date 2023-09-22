-- nvim tree
require("nvim-tree").setup({
    -- sort_by = "case_sensitive",
    view = {
        width = 40,
    },
    renderer = {
        group_empty = true,
    },
    git = {
        ignore = false,
    },
    hijack_cursor = true,
    on_attach = function(bufnr)
        local bufmap = function(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- See :help nvim-tree.api
        local api = require("nvim-tree.api")

        bufmap("L", api.node.open.edit, "Expand folder or go to file")
    end,
})

