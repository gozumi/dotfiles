-- core settings
vim.wo.relativenumber = true
vim.wo.number = true
vim.opt.shell = "/bin/zsh"
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.g.accent_colour = "yellow"
vim.g.accent_invert_status = 1

-- autofix typescript and javascript lint issues on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
    command = "silent! EslintFixAll",
    group = vim.api.nvim_create_augroup("MyAutocmdsJavaScripFormatting", {}),
})

