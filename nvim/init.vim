lua require("lpg2709.settings")
lua require("lpg2709.keybinds")
lua require("lpg2709.autocmd")

"---  Pluggins Load
call plug#begin('~/.config/nvim/plugged')            " Start plugin maneger

" - local dev
" Plug '/home/lguarezi/Documents/home/neovim-plug-studies'

" - Vim
Plug 'morhetz/gruvbox'                               " Grovbox colorscheme S2
" Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'luochen1990/rainbow'                           " showing diff level of
                                                     "   parentheses in diff
                                                     "   color
Plug 'jiangmiao/auto-pairs'                          " Insert or delete brackets
                                                     "   parens, quotes in pair.
Plug 'editorconfig/editorconfig-vim'                 " Editorsconfig plugint
Plug 'kyazdani42/nvim-tree.lua'                      " File explorer
Plug 'dhruvasagar/vim-table-mode'                    " Create tables
" Plug 'xolox/vim-misc'                                " used by vim-notes
" Plug 'xolox/vim-notes'                               " Notes

" - Neovim
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'

call plug#end()                                      " Fim da chamada

lua require('lpg2709.plugins')
