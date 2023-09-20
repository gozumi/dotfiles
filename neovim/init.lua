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
  {
    "rose-pine/neovim",
    name = "rose-pine"
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  },
  { "lukas-reineke/indent-blankline.nvim" },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter",
  },
  {
    'numToStr/Comment.nvim',
    opts = {
        -- add any options here
    },
    lazy = false,
  },
  "tpope/vim-surround",
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    dependencies = { 
      'nvim-lua/plenary.nvim'
    }
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  },
  {
    "akinsho/toggleterm.nvim",
    version = '*', 
  },
  "lewis6991/gitsigns.nvim",
})

-- colour scheme
require('rose-pine').setup({
  variant = 'moon'
})

vim.cmd('colorscheme rose-pine')

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
    ignore = false
  },
  hijack_cursor = true,
  on_attach = function(bufnr)
    local bufmap = function(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, { buffer = bufnr, desc = desc })
    end

    -- See :help nvim-tree.api
    local api = require('nvim-tree.api')

    bufmap('L', api.node.open.edit, 'Expand folder or go to file')
  end
})

-- lualine
require('lualine').setup({
  options = {
    path = 1,
    theme = 'rose-pine',
    icons_enabled = true,
    component_separators = '|',
    section_separators = '',
    disabled_filetypes = {
      statusline = { 'NvimTree' }
    }
  },
})

-- indent blank line
-- vim.opt.list = true
-- vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup {
    show_end_of_line = true,
}

-- tree sitter
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
    'javascript',
    'typescript',
    'tsx',
    'css',
    'json',
    'lua',
    'rust'
  },
})

-- comment
require('Comment').setup({})

-- nvim-tree
require('nvim-tree').setup({
  git = {
    ignore = false
  },
  hijack_cursor = true,
  on_attach = function(bufnr)
    local bufmap = function(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, { buffer = bufnr, desc = desc })
    end

    -- See :help nvim-tree.api
    local api = require('nvim-tree.api')

    bufmap('L', api.node.open.edit, 'Expand folder or go to file')
    bufmap('H', api.node.navigate.parent_close, 'Close parent folder')
    bufmap('gh', api.tree.toggle_hidden_filter, 'Toggle hidden files')
  end
})

-- telescope
require('telescope').setup({})
require('telescope').load_extension('fzf')

-- toggleterm
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

-- git signs
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
    map('n', '<leader>hp', gs.preview_hunk_inline)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
})

-- key mappings
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>')
vim.keymap.set('n', '<leader><space>', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>?', '<cmd>Telescope oldfiles<cr>')
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>')
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>')

