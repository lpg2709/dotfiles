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

command! Xs :mks! | :xa                              " Save the session,
                                                     "   modified files and exit
" set colorcolumn=80                                   " Indicative 80 char line
highlight ColorColumn ctermbg=0 guibg=lightgrey      " Color of 80 char line

"----------------------------- Pluggins Load ---------------------------------
call plug#begin('~/.vim/plugged')                    " Start plugin maneger

Plug 'neoclide/coc.nvim', {'branch': 'release'}      " Auto complete and more
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  " fzf for vim
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'                           " File tree
Plug 'ryanoasis/vim-devicons'                        " Icons, use NerdFonts
Plug 'terryma/vim-multiple-cursors'                  " Multi cursor
" Plug 'ycm-core/YouCompleteMe'                        " Auto complete
Plug 'morhetz/gruvbox'                               " Grovbox colorscheme S2
Plug 'vim-utils/vim-man'                             " man page vim
Plug 'luochen1990/rainbow'                           " showing diff level of
                                                     "   parentheses in diff
                                                     "   color
Plug 'jiangmiao/auto-pairs'                          " Insert or delete brackets
                                                     "   parens, quotes in pair.
Plug 'vim-airline/vim-airline'                       " Improved status bar
Plug 'vim-airline/vim-airline-themes'                " Themes for vim-airline
Plug 'puremourning/vimspector'                       " Debug UI for vim
Plug 'editorconfig/editorconfig-vim'                 " Editorsconfig plugint

call plug#end()                                      " Fim da chamada

"------------------------------ Theme config ---------------------------------
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

"------------------------------ Keys remaps ----------------------------------
" Show file tree
map <silent> <C-b> :NERDTreeToggle<CR>

" move para o buffer da esquerda
map <silent> <C-h> :wincmd h<CR>
" move para o buffer da direita
map <silent> <C-l> :wincmd l<CR>
" Ctrl-k duas vezes, ativa e desativa linha relativa ao cursor
nmap <silent> <C-k><C-k> :set invrelativenumber <CR>

" Comment Box
nnoremap <leader>* I*<Space><Esc>A<Space>*<ESC>I<ESC><C-V>$U<Esc>yy2P<C-V>
	\ $r*i/<ESC>jI<SPACE><ESC>j<C-V>$r*A/<ESC>I<SPACE><c-o>o<c-o>I

"---------------------------- Auto commnds  ----------------------------------
autocmd FileType vue setlocal tabstop=2 shiftwidth=2 expandtab

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
nnoremap <silent> <leader>c :call SetColumns() <CR>

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
"-------------------------------- Vim Note Configs ---------------------------
let g:notes_directories = ['~/Documents/Notes']
let g:notes_suffix = '.md'

"-------------------------------- Vimnspector Configs ------------------------
let g:vimspector_enable_mappings = 'HUMAN'

"-------------------------------- NERDTree Configs ---------------------------
let NERDTreeShowHidden=1

" Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p

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

"-------------------------------- COC Configs --------------------------------
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" ------------ After all execute ------------------------------------
" after a re-source, fix syntax matching issues (concealing brackets):
autocmd VimEnter * source ~/.vimrc " Reload config on init
if exists('g:loaded_webdevicons')
	call webdevicons#refresh()
endif
