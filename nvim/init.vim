lua require("lpg2709.settings")
lua require("lpg2709.keybinds")
lua require("lpg2709.autocmd")

"---  Pluggins Load

call plug#begin('~/.config/nvim/plugged')            " Start plugin maneger

" - local dev
" Plug '/home/lguarezi/Documents/home/neovim-plug-studies'

" - Vim
Plug 'terryma/vim-multiple-cursors'                  " Multi cursor
Plug 'morhetz/gruvbox'                               " Grovbox colorscheme S2
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'aymericbeaumet/vim-symlink'
Plug 'luochen1990/rainbow'                           " showing diff level of
                                                     "   parentheses in diff
                                                     "   color
Plug 'jiangmiao/auto-pairs'                          " Insert or delete brackets
                                                     "   parens, quotes in pair.
Plug 'editorconfig/editorconfig-vim'                 " Editorsconfig plugint
Plug 'kyazdani42/nvim-tree.lua'                      " File explorer
Plug 'dhruvasagar/vim-table-mode'                    " Create tables
Plug 'xolox/vim-misc'                                " used by vim-notes
Plug 'xolox/vim-notes'                               " Notes

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
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'

call plug#end()                                      " Fim da chamada

lua require('lpg2709.plugins')
lua require("luasnip.loaders.from_snipmate").lazy_load({ paths = {"./snippets"} })

" --- Theme config
" set to 0 if you want to enable it later via :RainbowToggle
let g:rainbow_active = 1
" Set gruvbox dark to airline
let g:gruvbox_termcolors = "16"
" Set colorscheme to Gruvbox
colorscheme gruvbox
" bg color
set background=dark
" Transparent background
hi Normal guibg=NONE ctermbg=NONE

" --- Set AutoPairsShortcutToggle to leader
let g:AutoPairsShortcutToggle = ''

" Comment Box
nnoremap <leader>* I*<Space><Esc>A<Space>*<ESC>I<ESC><C-V>$U<Esc>yy2P<C-V>
	\ $r*i/<ESC>jI<SPACE><ESC>j<C-V>$r*A/<ESC>I<SPACE><c-o>o<c-o>I

" --- Abreviations
iabbrev t_link <link rel="stylesheet" type="text/css" href="%"><Esc>F%s<c-o>
	\ :call getchar()<CR>
iabbrev t_script <script type="text/javascript" src="%"></script><Esc>F%s<c-o>
	\ :call getchar()<CR>
iabbrev t_html <ESC><F2>i<!DOCTYPE html><CR><html lang="en"><CR><head><CR><TAB>
	\ <meta charset="UTF-8"><CR><TAB><meta http-equiv="X-UA-Compatible"
	\ content="IE=edge"><CR><TAB><meta name="viewport"
	\ content="width=device-width, initial-scale=1.0"><CR><TAB><title>%</title>
	\ <CR></head><CR><body><CR><CR><CR></body><CR></html><c-o>6k<c-o>A<ESC>F%s
	\ <c-o>:call getchar()<CR><ESC><F2>

" --- Vim Note Configs
let g:notes_directories = ['/mnt/c/Users/leonardo.guarezi/Dropbox/lguarezi/Notes']
let g:notes_suffix = '.md'

" --- Table mode config
" let g:table_mode_corner_corner='|'
" let g:table_mode_corner='+'





" press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
" -1 for jumping backwards.
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

" For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
