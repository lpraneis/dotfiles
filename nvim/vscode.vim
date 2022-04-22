"Plugins {{{

" Vim Plugged
call plug#begin('~/.local/share/nvim/plugged')

" Lightline
" Plug 'itchyny/lightline.vim'

"Git Plugin
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb' 

Plug 'tpope/vim-commentary'

Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-obsession'

call plug#end()

function! s:has_plugin(plugin)
  let lookup = 'g:plugs["' . a:plugin . '"]'
  return exists(lookup)
endfunction
"}}}

" General Configuration {{{
    " Enable editing of binary files
set binary

" Set shell to zsh
set shell=/usr/bin/zsh

" set runtimepath+=~/.vim,~/.vim/after
" set packpath+=~/.vim
set path+=.,/usr/local/include,/usr/include,/usr/include/x86_64-linux-gnu/

" Briefly move cursor to matching brace
set showmatch

" Lazyredraw attempts to solve lag by reducing
" the amount of processing required. Any action
" that is not typed will not cause screen to redraw
set lazyredraw

"NASM syntax
let g:asmsyntax='asm'

"When 'wildmenu' is on, command-line
"completion operates in an enhanced mode.
set wildmenu

" Incremental search results
set incsearch

"Show column
set ruler

" Show partial command as it's being typed
set showcmd
" Centralize BAckups, Swapfiles, and Undo History
set backupdir=~/.config/nvim/backups

" Don't create backups when editing files in certain dirs
set backupskip=/tmp/*

" Don't add extra space after ., !, etc. when joining
set nojoinspaces


" Uses spaces not tabs
set expandtab
set tabstop=4
set shiftwidth=2

" Highlight current line
set cursorline
" detect when a file is changed
set autoread 

" enable relative line numbers
set number
set rnu 

let mapleader = ',' "setting a leader to ,
let maplocalleader='\'

" Enable Syntax
syntax enable
syntax on
" Enable 24 bit color
set termguicolors

"Opening new file in buffer casues file to be hidden instead of closed 
set hidden
"
"Vim One Color Config
set background=dark
let g:one_allow_italics = 1
let g:one_dark_syntax_bg='#242424'
if s:has_plugin('vim-one')
  colorscheme one
  call one#highlight('rustCommentLine', '959595', '', 'none')
  call one#highlight('rustCommentBlock', '959595', '', 'none')
  call one#highlight('rustCommentBlockDoc', '959595', '', 'none')
  call one#highlight('rustCommentLineDoc', '959595', '', 'none')
endif

" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Splits open bottom right, more natural
set splitbelow
set splitright

" Don't display current mode, airline has it
set noshowmode
"}}}

"Automatically correct the last word
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
" }}}

" Map ,e... to edit in new window, split, vertical, tab, from current
" directory.
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>


"keybindings for buffer transversal
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>


"keybinding to use F8 to open file under cursor in vertical split!
map <leader>v :vertical wincmd f<CR>
map <leader>h :wincmd f<CR>

"keybinding for active file directory completion
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

"Keybinding to clear highlighting after search
nnoremap <leader>c :nohl<CR>

"Keybindings to go with ctags!
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
set tags+=tags;$HOME

"Keybindings for 'exiting terminal' "
tnoremap <Esc> <C-\><C-n>
"}}}

" VSCODE specific keybindings
" {{{
nnoremap <silent>H  :<C-U>call VSCodeNotify('workbench.action.quickOpenNavigatePreviousInEditorPicker')<CR>
nnoremap <silent>L  :<C-U>call VSCodeNotify('workbench.action.quickOpenNavigateNextInEditorPicker')<CR>
nnoremap <silent>D  :<C-U>call VSCodeNotify('editor.action.showHover')<CR>
nnoremap <leader>p  :<C-U>call VSCodeNotify('editor.action.showDefinitionPreviewHover')<CR>
nnoremap <space>g   :<C-U>call VSCodeNotify('editor.action.formatDocument')<CR>

" Switch buffers
nnoremap <silent>H :silent bp<CR>
nnoremap <silent>L :silent bn<CR>

"}}}

