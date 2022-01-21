" colorscheme
let g:one_allow_italics=1
let g:one_dark_syntax_bg="#121212"
colorscheme one

" Utility function to check if we're loading a plugin
" * Prevents breaking vimrc if a plugin is removed
function! s:has_plugin(plugin)
	let lookup = 'g:plugs["' . a:plugin . '"]'
	return exists(lookup)
endfunction


if s:has_plugin('vim-markdown-folding')
	set nocompatible
	if has("autocmd")
		filetype plugin indent on
	endif
endif

if s:has_plugin('vim-startify')
	let g:startify_files_number = 10
	let g:staritfy_change_to_dir = 0
	let g:startify_custom_header =  [ ]
	let g:startify_relative_path = 1
	let g:startify_use_env = 1

	let g:startify_lists = [
				\ {'type': 'dir', 'header': [ 'Files '. getcwd() ] },
				\ {'type': 'bookmarks', 'header': ['Bookmarks'] },
				\ {'type': 'commands', 'header': ['Commands'] },
				\]
	let g:startify_bookmarks = [
				\ { 'c': 'C:\Users\lpraneis\AppData\Local\nvim\init.vim'},
				\ { 'i': 'C:\Users\lpraneis\AppData\Local\nvim\init.vscode.vim'},
				\ { 'v': 'C:\Users\lpraneis\.vsvimrc'},
				\ { 's': 'C:\Users\lpraneis\.ssh\config'},
				\ { 'h': 'C:\Windows\system32\drivers\etc\hosts'},
				\ { 'f': 'D:\osi\v13\monarch\src\.clang-format'},
				\]

	let g:startify_commands = [
				\ {'up': ['Update Plugins', ':PlugUpdate']},
				\ {'pc': ['Clean Plugins', ':PlugClean']},
				\ ]

	autocmd User Startified setlocal cursorline
endif



let g:clang_format#filetype_style_options = {
			\'cpp' : {
				\ "Standard" : "C++11",
				\ "Language" : "Cpp"
				\},
				\ }

