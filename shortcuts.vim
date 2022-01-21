
" Get rid of search highlighting
nnoremap <leader>c :nohl<cr>

" Map H,L to buffer change ( mimic tabs, but better )
nnoremap <silent>H :silent bp<CR>
nnoremap <silent>L :silent bn<CR>

" Map ,e... to edit in new window, split, vertical, tab, from current directory.
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>

" Some space utilities for common functions
map <space>f :ClangFormat<CR>
map <space>m :Make<CR>
map <space>t :Make test<CR>

" Kill all of the buffers except the current one
map <leader>bo :w <bar> %bd <bar> e# <bar> bd# <CR>

" Quickfix 
nnoremap <silent>]c :cnext<CR>
nnoremap <silent>[c :cprev<CR>
map <space>c :cclose<CR>

" Telescope!
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fs <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fgc <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <leader>fgs <cmd>lua require('telescope.builtin').git_status()<cr>
nnoremap <leader>fgb <cmd>lua require('telescope.builtin').git_bcommits()<cr>
nnoremap <leader>fr <cmd>lua require('telescope.builtin').lsp_references()<cr>

" Append modeline after last line in buffer
function! AppendModeLine()
	let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
				\ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
	let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
	call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <leader>ml :call AppendModeLine()<CR>
