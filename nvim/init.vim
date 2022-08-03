"---  Native Config

syntax on                                            " Highlight on

set exrc                                             " Auto load project configs
set noerrorbells                                     " No error sound
set tabstop=4                                        " 1 tab = 4 Spaces
set shiftwidth=4                                     " 1 tab = 4 Space for << >>
set scrolloff=8                                      " Scroll ofset, 8 lines
set cursorline
set number                                           " Line numbers
set hidden
set norelativenumber                                 " Relative line to cursor
set smartindent                                      " Set auto intent
set nowrap                                           " Line can off set screen
set smartcase                                        " Case sensitive for search
set noswapfile                                       " No swap file
set nobackup                                         " Remove bkp file
set undodir=~/.vim/undodir                           " Undo file save in folder
set undofile                                         " Undo file for all file
set incsearch                                        " Highlight search
set cmdheight=2
set pastetoggle=<F2>                                 " F2 toggle paste mode
set updatetime=300
set shortmess+=c
set guicursor=i:block                                " Cursor block
set nohlsearch
let mapleader = " "

command! Xs :mks! | :xa                              " Save the session,
                                                     "   modified files and exit
" set colorcolumn=80                                   " Indicative 80 char line
highlight ColorColumn ctermbg=0 guibg=lightgrey      " Color of 80 char line

"---  Pluggins Load

call plug#begin('~/.config/nvim/plugged')            " Start plugin maneger

" - Vim
Plug 'terryma/vim-multiple-cursors'                  " Multi cursor
Plug 'morhetz/gruvbox'                               " Grovbox colorscheme S2
Plug 'luochen1990/rainbow'                           " showing diff level of
                                                     "   parentheses in diff
                                                     "   color
Plug 'jiangmiao/auto-pairs'                          " Insert or delete brackets
                                                     "   parens, quotes in pair.
Plug 'editorconfig/editorconfig-vim'                 " Editorsconfig plugint
Plug 'kyazdani42/nvim-tree.lua'                      " File explorer

" - Neovim
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'  }
Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
" Plug 'williamboman/nvim-lsp-installer'

call plug#end()                                      " Fim da chamada

set completeopt=menu,menuone,noselect

lua require('lpg2709')

" --- Theme config
" set to 0 if you want to enable it later via :RainbowToggle
let g:rainbow_active = 1
" Set gruvbox dark to airline
let g:airline_theme = 'base16_gruvbox_dark_hard'
let g:gruvbox_contrast_dark = 'hard'
" Set colorscheme to Gruvbox
colorscheme gruvbox
" bg color
set background=dark
" Transparent background
hi Normal guibg=NONE ctermbg=NONE

" ---  Keys remaps
" map <silent> <C-b> :NERDTreeToggle<CR>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" move para o buffer da esquerda
map <silent> <C-h> :wincmd h<CR>
" move para o buffer da direita
map <silent> <C-l> :wincmd l<CR>
" Ctrl-k duas vezes, ativa e desativa linha relativa ao cursor
nnoremap <silent> <leader>k <cmd>:set invrelativenumber <CR>

" Comment Box
nnoremap <leader>* I*<Space><Esc>A<Space>*<ESC>I<ESC><C-V>$U<Esc>yy2P<C-V>
	\ $r*i/<ESC>jI<SPACE><ESC>j<C-V>$r*A/<ESC>I<SPACE><c-o>o<c-o>I

" --- Auto commnds
autocmd FileType vue setlocal tabstop=2 shiftwidth=2 expandtab

" --- Functions
" Remove sapces
augroup DEFAULT_FILES
	autocmd!
	autocmd BufWritePre * %s/\s\+$//e
augroup END

" Set column [Key bind: \+c]
function! SetColumns()
	:execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")
endfunction
nnoremap <silent> <leader>c :call SetColumns() <CR>

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
let g:notes_directories = ['~/Documents/Notes']
let g:notes_suffix = '.md'

