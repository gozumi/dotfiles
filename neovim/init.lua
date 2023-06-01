vim.wo.relativenumber = true
vim.wo.number = true 
vim.opt.shell = "/bin/zsh"

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.g.accent_colour = "yellow"
vim.g.accent_invert_status = 1

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
-- "folke/tokyonight.nvim",
  "alligator/accent.vim",
  "neovim/nvim-lspconfig",
  "nvim-lualine/lualine.nvim",
  "lukas-reineke/indent-blankline.nvim",
  "nvim-treesitter/nvim-treesitter",
  "nvim-treesitter/nvim-treesitter-textobjects",
  "numToStr/Comment.nvim",
  "nvim-telescope/telescope.nvim",
  "nvim-lua/plenary.nvim",
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = false },
  "akinsho/toggleterm.nvim",
  { "junegunn/fzf", run = "./install --bin" },
  "tpope/vim-fugitive",
  { "ray-x/guihua.lua", run = "cd lua/fzy && make" },
  "ray-x/forgit.nvim",
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons",
  "lewis6991/gitsigns.nvim"
})

vim.cmd('colorscheme accent')
-- vim.cmd('colorscheme tokyonight')

-- require("tokyonight").setup({
--  transparent = true,
-- })

vim.opt.showmode = false

require('lualine').setup({
  options = {
    theme = 'onedark',
    icons_enabled = true,
    component_separators = '|',
    section_separators = '',
    disabled_filetypes = {
      statusline = {'NvimTree'}
    }
  },
})

require('indent_blankline').setup({
  char = '_',
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,
  use_treesitter = true,
  show_current_context = true 
})

require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  },
  ensure_installed = {
    'javascript',
    'typescript',
    'tsx',
    'css',
    'json',
    'lua',
  },
})

require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      }
    },
  },
  ensure_installed = {
    --- parsers....
  },
})

require('Comment').setup({})

require('nvim-tree').setup({
  hijack_cursor = true,
  on_attach = function(bufnr)
    local bufmap = function(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, {buffer = bufnr, desc = desc})
    end

    -- See :help nvim-tree.api
    local api = require('nvim-tree.api')
   
    bufmap('L', api.node.open.edit, 'Expand folder or go to file')
    bufmap('H', api.node.navigate.parent_close, 'Close parent folder')
    bufmap('gh', api.tree.toggle_hidden_filter, 'Toggle hidden files')
  end
})

vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>')

vim.keymap.set('n', '<leader><space>', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>?', '<cmd>Telescope oldfiles<cr>')
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>')
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>')

require('telescope').load_extension('fzf')

require('toggleterm').setup({
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = '<C-g>',
  direction = 'vertical',
  shade_terminals = true
})

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')

require'forgit'.setup({
  debug = false, -- enable debug logging default path is ~/.cache/nvim/forgit.log
  diff_pager = 'delta', -- you can use `diff`, `diff-so-fancy`
  diff_cmd = '', -- you can use `DiffviewOpen`, `Gvdiffsplit` or `!git diff`, auto if not set
  fugitive = false, -- git fugitive installed?
  abbreviate = false, -- abvreviate some of the commands e.g. gps -> git push
  git_alias = true,  -- git command extensions see: Git command alias
  show_result = 'quickfix', -- show cmd result in quickfix or notify

  shell_mode = true, -- set to true if you using zsh/bash and can not run forgit commands
  height_ratio = 0.6, -- height ratio of floating window when split horizontally
  width_ratio = 0.6, -- width ratio of floating window when split vertically
  cmds_list = {} -- additional commands to show in Forgit command list
  --  e.g. cmd_list = {text = 'Gs get_hunks', cmd = 'Gitsigns get_hunks'}
})

-- default mapping
maps = {
  close_view = '<C-e>',
  send_qf = '<C-q>',
  save = '<C-s>',
  jump_to_list = '<C-w>k',
  jump_to_preview = '<C-w>j',
  prev = '<C-p>',
  next = '<C-n>',
  pageup = '<C-b>',
  pagedown = '<C-f>',
  confirm = '<C-o>',
  split = '<C-s>',
  vsplit = '<C-v>',
  tabnew = '<C-t>',
}

  --
require('guihua.maps').setup({
  maps = {
    close_view = '<C-x>',
  }
})

require('gitsigns').setup({
  signs = {
    add = {text = '▎'},
    change = {text = '▎'},
    delete = {text = '➤'},
    topdelete = {text = '➤'},
    changedelete = {text = '▎'},
  },

  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Actions
    map('n', '<leader>hs', gs.stage_hunk)
    map('n', '<leader>hr', gs.reset_hunk)
    map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end)
    map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line("."), vim.fn.line("v")} end)
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
end
})

