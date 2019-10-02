call plug#begin('~/.local/share/nvim/plugged')

" General {{{
    set t_8b=^[[48;2;%lu;%lu;%lum
    set t_8f=^[[38;2;%lu;%lu;%lum
    set runtimepath+=~/.vim,~/.vim/after
    set packpath+=~/.vim
    set path+=.,/usr/local/include,/usr/include,/usr/include/x86_64-linux-gnu/
    set guicursor=
    set shell=/usr/bin/zsh
    set tabstop=4
    set shiftwidth=2
    set expandtab
    set number
    set showcmd
    set showmatch
    set cursorline
    set wildmenu
    set incsearch
    set autoread " detect when a file is changed
    set rnu " enable relative line numbers
    syntax enable
    let mapleader = ',' "setting a leader to ,
"}}}

"Lightline: {{{
Plug 'itchyny/lightline.vim'
" Plug 'maximbaz/lightline-ale'
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \      'left':[ ['mode', 'paste' ], 
      \               [ 'gitbranch', 'readonly', 'filename','modified']
      \               ],
      \      'right':[['percent'],['fileformat', 'fileencoding', 'filetype' ], ['cocstatus'] ]
      \  },
      \  'component_function': {
      \  'gitbranch': 'fugitive#head',
      \  'cocstatus': 'coc#status', 
      \  },
      \  'component_type': {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \    },
      \  }

"}}}

"Syntax - COC {{{
"

" Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
" Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

" if hidden not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Scroll floating window
nnoremap <expr><C-f> coc#util#has_float() ? coc#util#float_scroll(1) : "\<C-f>"
nnoremap <expr><C-b> coc#util#has_float() ? coc#util#float_scroll(0) : "\<C-b>"

"use <c-;> for snippets"
imap <C-e> <Plug>(coc-snippets-expand)
vmap <C-e> <Plug>(coc-snippets-select)

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> D  :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd CursorHoldI * silent call CocActionAsync('showSignatureHelp')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>F  <Plug>(coc-format-selected)
nmap <leader>F  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

 "Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocCommand<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
autocmd CompleteDone * pclose!


"C shortcuts
nn <silent> xb :call CocLocations('ccls','$ccls/inheritance')<cr>
" bases of up to 3 levels
nn <silent> xb :call CocLocations('ccls','$ccls/inheritance',{'levels':3})<cr>
" derived
nn <silent> xd :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true})<cr>
" derived of up to 3 levels
nn <silent> xD :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true,'levels':3})<cr>

" caller
nn <silent> xc :call CocLocations('ccls','$ccls/call')<cr>
" callee
nn <silent> xC :call CocLocations('ccls','$ccls/call',{'callee':v:true})<cr>

" $ccls/member
" member variables / variables in a namespace
nn <silent> xm :call CocLocations('ccls','$ccls/member')<cr>
" member functions / functions in a namespace
nn <silent> xf :call CocLocations('ccls','$ccls/member',{'kind':3})<cr>
" nested classes / types in a namespace
nn <silent> xs :call CocLocations('ccls','$ccls/member',{'kind':2})<cr>

nmap <silent> xt <Plug>(coc-type-definition)<cr>
nn <silent> xv :call CocLocations('ccls','$ccls/vars')<cr>
nn <silent> xV :call CocLocations('ccls','$ccls/vars',{'kind':1})<cr>
nn xx x

let g:python_host_prog='/home/logan/python-virtual-environments/nvim2/bin/python'
let g:python3_host_prog='/home/logan/python-virtual-environments/nvim3/bin/python'
"python virtual environments :q
"
"

"}}}

"{{{ Other Syntax
"rust syntax
" Plug 'rust-lang/rust.vim'
" These two commands make the tags by rusty tags vi
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

"Latex Plugin
Plug 'lervag/vimtex'
" let g:vimtex_compiler_progname= 'nvr'
let g:vimtex_compiler_progname= 'latexmk'
" let g:vimtex_compiler_latexmk = {
"     \ 'options' : '-pdf -verbose -bibtex -file-line-error -synctex=1 --interaction=nonstopmode',
"     \}
let g:vimtex_enabled = 1
let g:vimtex_fold_enabled = 1
"Vimtex Call FZF shortcut:
nnoremap <leader>lt :call vimtex#fzf#run()<cr>

"Automatically correct the last word
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u


"TOML syntax
Plug 'cespare/vim-toml'

" Terraform Syntax
Plug 'hashivim/vim-terraform'
" Vim Snippets Support
Plug 'honza/vim-snippets'

"GDB Integration {{{
Plug 'sakhnik/nvim-gdb', { 'branch': 'legacy' }
" Plug 'sakhnik/nvim-gdb', { 'do': './install.sh' }
"}}}

"Tim Pope {{{
"Sensible Defaults! - Tim Pope
Plug 'tpope/vim-sensible'

" Add endifs etc. automaticly
Plug 'tpope/vim-endwise'
"Dispatch --- asynchonous make - Tim Pope
Plug 'tpope/vim-dispatch'
"Git Plugin
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb' 
let g:github_enterprise_urls = ['https://github.umn.edu']

Plug 'tpope/vim-commentary'

Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-obsession'

" }}}
"
" }}}

"#####################
"       Others
"#####################
"{{{

"Easy tables in vim! (note taking, etc)
Plug 'dhruvasagar/vim-table-mode'

" Clang auto-formatter
Plug 'rhysd/vim-clang-format'

" R Markdown
Plug 'vim-pandoc/vim-pandoc'
let g:pandoc#folding#fastfolds = 1
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-rmarkdown'
"Markdown Instant Preview --- TEST
Plug 'iamcco/markdown-preview.vim'
let g:mkdp_refresh_slow = 1 "sets it to only refresh on leaving insert mode or on write
map <leader>mp :MarkdownPreview
map <leader>pc :Pandoc pdf --template eisvogel --listings<CR>
map <leader>pv :!evince %:p:r.pdf<CR>

Plug 'mbbill/undotree'
nnoremap <F2> :UndotreeToggle<cr>


Plug 'kkoomen/vim-doge'
let g:doge_doc_standard_python='google'
let g:doge_mapping='<Leader>g'
let g:doge_mapping_comment_jump_forward='<C-e>'
let g:doge_mapping_comment_jump_forward='<C-r>'


"netrw config
" absolute width of netrw window
nnoremap <F3> :Lexplore <cr>
let g:netrw_winsize = -28

" do not display info on the top of window
let g:netrw_banner = 0

" tree-view
let g:netrw_liststyle = 3

" sort is affecting only: directories on the top, files below
let g:netrw_sort_sequence = '[\/]$,*'

" use the previous window to open file
let g:netrw_browse_split = 4
"}}}

"fuzzy finder {{{
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'fszymanski/fzf-quickfix'

"Hide status line for fzf in terminal buffer

" Map ,e... to edit in new window, split, vertical, tab, from current
" directory.
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>
"}}}

"#####################
"       Folding
"#####################
"{{{
" FOLD SETTING INSIDE VIMRC
function SetFold()
  set foldmethod=marker   
  set foldlevelstart=99   
  set foldnestmax=10   
  set nofoldenable   
  set foldlevel=0
endfunction

augroup FOLDVIM
  autocmd!
  autocmd FileType vim  call SetFold()
augroup END
"
"Python folding
Plug 'tmhedberg/SimpylFold'
"

"Fast Folding
Plug 'Konfekt/FastFold'
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes = ['x', 'X', 'a', 'A', 'o', 'O', 'c', 'C' ]
let g:fastfold_fold_movement_commands = [']z', '[Z', 'zj', 'zk']

let g:markdown_folding = 1
let g:tex_fold_enabled =1 
let g:rust_fold = 1

"}}}


"Themes {{{
" Plug 'rakr/vim-one'
Plug 'laggardkernel/vim-one'
"}}}

"Buffers {{{
Plug 'qpkorr/vim-bufkill'
Plug 'tpope/vim-tbone'

"}}}

" Startify: Fancy startup screen for vim {{{
        Plug 'mhinz/vim-startify'

        " Don't change to directory when selecting a file
        let g:startify_files_number = 7
        let g:startify_change_to_dir = 0
        let g:startify_custom_header = [ ]
        let g:startify_relative_path = 1
        let g:startify_use_env = 1

        function! s:list_commits()
            let git = 'git -C ' . getcwd()
            let commits = systemlist(git . ' log --oneline | head -n5')
            let git = 'G' . git[1:]
            return map(commits, '{"line": matchstr(v:val, "\\s\\zs.*"), "cmd": "'. git .' show ". matchstr(v:val, "^\\x\\+") }')
        endfunction

        " Custom startup list, only show MRU from current directory/project
        let g:startify_lists = [
        \  { 'type': 'dir',       'header': [ 'Files '. getcwd() ] },
        \  { 'type': 'sessions',       'header': [ 'Sessions '. getcwd() ] },
        \  { 'type': function('s:list_commits'), 'header': [ 'Recent Commits' ] },
        \  { 'type': 'sessions',  'header': [ 'Sessions' ]       },
        \  { 'type': 'bookmarks', 'header': [ 'Bookmarks' ]      },
        \  { 'type': 'commands',  'header': [ 'Commands' ]       },
        \ ]

        let g:startify_commands = [
        \   { 'up': [ 'Update Plugins', ':PlugUpdate' ] },
        \   { 'ug': [ 'Upgrade Plugin Manager', ':PlugUpgrade' ] },
        \   { 'ur': [ 'Update Remote Plugins ', ':UpdateRemotePlugins' ] },
        \   { 'pc': [ 'Clean Plugins', ':PlugClean' ] },
        \ ]

        let g:startify_bookmarks = [
            \ { 'c': '~/dotfiles/init.vim' },
            \ { 'z': '~/dotfiles/.zshrc' },
            \ { 'l': '~/.config/nvim/coc-settings.json'},
        \ ]

        autocmd User Startified setlocal cursorline

    " }}}

"Keybindings:  {{{

 
"keybindings for buffer transversal
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>


"keybinding for split navigations
map <silent> <C-h> :call functions#WinMove('h')<cr>
map <silent> <C-j> :call functions#WinMove('j')<cr>
map <silent> <C-k> :call functions#WinMove('k')<cr>
map <silent> <C-l> :call functions#WinMove('l')<cr>
set splitbelow
set splitright

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

"Keybindings for fzf (FZF)
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>m :Marks<cr>
nnoremap <leader>w :Windows<cr>
nnoremap <leader>t :Tags<cr>
nnoremap <leader>f :Files<cr>




"Keybindings for 'exiting terminal' "
tnoremap <Esc> <C-\><C-n>

"Add keybinding for quitting insert mode
" inoremap kj <Esc>
" inoremap jk <Esc> 

"}}}

"Commands: {{{
"Command for clearing registers
command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor
command! T split | terminal
command! Vt vsplit | terminal 

"}}}
"

"Filetype Commands: {{{
autocmd Filetype python setlocal expandtab 
autocmd Filetype ocaml setlocal shiftwidth=2 softtabstop=2
autocmd Filetype c,cpp,cc setlocal foldmethod=syntax

autocmd FileType ocaml setlocal commentstring=(*\%s\*)
autocmd FileType tex setlocal spell
autocmd FileType plaintex setlocal spell
autocmd FileType markdown setlocal spell expandtab softtabstop=4 shiftwidth=4

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
"}}}

call plug#end()
"Custom source for vimtex completion
"
" call deoplete#custom#var('omni', 'input_patterns', {
"       \ 'tex' : g:vimtex#re#deoplete,
" \})
syntax on
set termguicolors
"
"Vim One
set background=dark
let g:one_allow_italics = 1
colorscheme one
