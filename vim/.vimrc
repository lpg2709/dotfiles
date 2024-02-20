"----------------------------- Native Config ---------------------------------
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
let mapleader = " "                                  " Space as leader Space as leader

command! Xs :mks! | :xa                              " Save the session,
                                                     "   modified files and exit
" set colorcolumn=80                                   " Indicative 80 char line
highlight ColorColumn ctermbg=0 guibg=lightgrey      " Color of 80 char line

"----------------------------- Pluggins Load ---------------------------------
call plug#begin('~/.vim/plugged')                    " Start plugin maneger

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  " fzf for vim
Plug 'junegunn/fzf.vim'
Plug 'ryanoasis/vim-devicons'                        " Icons, use NerdFonts
Plug 'morhetz/gruvbox'                               " Grovbox colorscheme S2
Plug 'jiangmiao/auto-pairs'                          " Insert or delete brackets
                                                     "   parens, quotes in pair.
Plug 'editorconfig/editorconfig-vim'                 " Editorsconfig plugint

call plug#end()                                      " Fim da chamada

"------------------------------ Theme config ---------------------------------
" Set theme for status line
set laststatus=2
" Set colorscheme to Gruvbox
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'medium'
" bg color
set background=dark
" Transparent background
" hi Normal guibg=NONE ctermbg=NONE

"------------------------------ Keys remaps ----------------------------------
" Show file tree
map <silent> <C-b> :Sexplorer<CR>

" move para o buffer da esquerda
map <silent> <C-h> :wincmd h<CR>
" move para o buffer da direita
map <silent> <C-l> :wincmd l<CR>
" move para o buffer de cima
map <silent> <C-k> :wincmd k<CR>
" move para o buffer de baixo
map <silent> <C-j> :wincmd j<CR>
" Ctrl-k duas vezes, ativa e desativa linha relativa ao cursor
nmap <silent> <leader>n :set invrelativenumber <CR>

" Comment Box
nnoremap <leader>* I*<Space><Esc>A<Space>*<ESC>I<ESC><C-V>$U<Esc>yy2P<C-V>
	\ $r*i/<ESC>jI<SPACE><ESC>j<C-V>$r*A/<ESC>I<SPACE><c-o>o<c-o>I

" FZF find files
map <silent> <leader>ff :Files<CR>
" FZF find buffers
map <silent> <leader>fb :Buffers<CR>
" FZF live grap
map <silent> <leader>fg :Rg<CR>

"------------------------------ Functions  -----------------------------------
" Remove sapces
augroup DEFAULT_FILES
	autocmd!
	autocmd BufWritePre * %s/\s\+$//e
augroup END

" Reload Syntax highlight
function ReloadSyntax()
	syntax sync fromstart
	echom "Syntax reloaded!"
endfunction

" Set column [Key bind: \+c]
function! SetColumns()
	:execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")
endfunction
nnoremap <silent> <leader>k :call SetColumns() <CR>

"----------------------------- Abreviations ----------------------------------
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
iabbrev *{ <ESC><F2>i*{<CR><TAB>margin: 0;<CR><TAB>padding: 0;<CR><TAB>
	\ box-sizing: border-box;<CR>}<ESC><F2>i
iabbrev log@ console.log(%);<ESC>F%s<c-o>:call getchar()<CR>

"-------------------------------- FZF Configs --------------------------------
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
let g:fzf_colors =
  \ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Normal'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" ------------ After all execute ------------------------------------
" after a re-source, fix syntax matching issues (concealing brackets):
autocmd VimEnter * source ~/.vimrc " Reload config on init
if exists('g:loaded_webdevicons')
	call webdevicons#refresh()
endif
