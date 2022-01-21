" Color
set background=dark
set termguicolors

" Text formatting
set showbreak=↪
set list
set listchars=tab:→\ ,
set showmatch

" Perf
set updatetime=300
set shortmess+=c

" Menus / Screen formatting
set incsearch
set wildmenu
set ruler
set cursorline
set number
set rnu
set hidden
set cmdheight=2
set splitbelow
set splitright
set modeline
set modelines=5
set fileformat=dos

" Ignore binary file types for edit, etc. completion
set wildignore=*.zip,*.png,*.jpg,*.gif,*.pdf,*DS_Store*,*.obj,*.o,*.dll,*.exe,*.a,*.lib,*.pdb

" Set vars
let mapleader = ','
let maplocalleader='\'

" Enable syntax
syntax enable
syntax on

" Tab garbage
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set nojoinspaces

" Remove backups, for ease of file editing
set nobackup
set nowritebackup

" Marker based folding
set foldmethod=marker
set foldlevelstart=99
set foldnestmax=10
set nofoldenable
set foldlevel=0
