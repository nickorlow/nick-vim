--- BEGIN MY CONFIG 
vim.opt.compatible = false
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wildmode = "longest,list"
vim.opt.colorcolumn = "80"
vim.cmd("filetype plugin indent on")
vim.cmd("syntax on")
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.ttyfast = true
vim.opt.termguicolors = true

-- Setup line & col highlighting
vim.opt.cursorline = true
vim.cmd('highlight CursorLine guibg=#202020 ctermbg=235 guisp=NONE gui=NONE cterm=NONE')
vim.cmd('highlight CursorLineNr guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE gui=NONE cterm=NONE')
vim.opt.cursorcolumn = true

-- BEGIN SETUP FOR LAZY NVIM
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
require("lazy").setup({
{
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {}
  end,
},
	{
		"vim-airline/vim-airline",
		lazy = false,
		priority = 1000,
		dependencies = {
			"vim-airline/vim-airline-themes",
			"ryanoasis/vim-devicons",
		}
	},
    {
        "bling/vim-bufferline",
        lazy = false,
    },
{ "lukas-reineke/indent-blankline.nvim" },

  {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},         -- Required
            {'hrsh7th/cmp-nvim-lsp'},     -- Required
            {'hrsh7th/cmp-buffer'},       -- Optional
            {'hrsh7th/cmp-path'},         -- Optional
            {'saadparwaiz1/cmp_luasnip'}, -- Optional
            {'hrsh7th/cmp-nvim-lua'},     -- Optional

            -- Snippets
            {'L3MON4D3/LuaSnip'},             -- Required
            {'rafamadriz/friendly-snippets'}, -- Optional
        }
    },{
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy",
  opts = {},
  config = function(_, opts) require'lsp_signature'.setup(opts) end
},
{'junegunn/rainbow_parentheses.vim'},
{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
   autoInstall = true,
}
)

-- BEGIN SETUP FOR NVIM TREE
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
    root_folder_label = false
  },
  filters = {
    custom = { "^.git$" },
    dotfiles = false,
  },
})

-- bind ctrl n to open tree
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- BEGIN SETUP FOR AIRLINE
vim.g.airline_theme = 'deus'
vim.g.airline_extensions_tabline_enabled = 0
if not vim.g.airline_symbols then
    vim.g.airline_symbols = {}
end

vim.g.airline_left_sep = ''
vim.g.airline_left_alt_sep = ''
vim.g.airline_right_sep = ''
vim.g.airline_right_alt_sep = ''

vim.g.airline_symbols.branch = ''
vim.g.airline_symbols.readonly = ''
vim.g.airline_symbols.linenr = '☰'
vim.g.airline_symbols.maxlinenr = ''
vim.g.airline_symbols.dirty = '⚡'
vim.opt.laststatus=3
vim.opt.showmode = false

-- BEGIN TREESITTER CONFIG
--require('nvim-treesitter.configs').setup {
--  ensure_installed = { "c" },
--  sync_install = true,
--  auto_install = true,
--
--  highlight = {
--    enable = true,
-- },
--  rainbow = {
--    enable = true,
--    query = 'rainbow-parens',
--    strategy = require('ts-rainbow').strategy.global,
--  }
--}
local lsp = require('lsp-zero')
lsp.preset('recommended')

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()
lsp.set_preferences({
  suggest_lsp_servers = false,
  });
lsp.setup()

require("mason-lspconfig").setup {
    ensure_installed = { "clangd", "rust_analyzer", "onmisharp", "gopls", "python-lsp-server", "javascript-typescript" },
}
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
})
-- BEGIN BACK TO MY CONFIT

-- Disable tilde newlines
vim.cmd('highlight NonText guifg=bg')
vim.opt.fillchars = {eob = " "}

-- Define a highlight group for VertSplit
vim.cmd('highlight VertSplit ctermbg=NONE guibg=NONE')
vim.opt.fillchars = vim.opt.fillchars + { vert = '│' }

-- BEGIN LSP CONFIG

require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
})

vim.cmd('colorscheme catppuccin')
vim.g.rainbow_pairs = {{'(', ')'}, {'[', ']'}, {'{', '}'}}
vim.cmd('RainbowParentheses')
