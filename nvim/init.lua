local sys = require('sys')
local maps = require('maps')
local fs = require('fs')

local o = vim.o
local wo = vim.wo
local nnoremap = maps.nnoremap
local map = vim.api.nvim_set_keymap

vim.g.mapleader = ','

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Use lua/plugins/*.lua to split up plugin load
require('lazy').setup("plugins",
	{
		-- simplify some of the icons
		ui = {
			icons = {
				cmd = "",
				config = "",
				event = "",
				ft = " ",
				init = " ",
				import = " ",
				keys = " ",
				lazy = "",
				loaded = "●",
				not_loaded = "○",
				plugin = " ",
				runtime = " ",
				source = " ",
				start = "➜",
				task = "✔ ",
				list = {
					"●",
					"➜",
					"★",
					"‒",
				},
			},
		}
	}
)

-- Global vim settings
o.autoindent = true
o.autoread = true
o.autowrite = true
o.backspace = 'indent,eol,start'
o.expandtab = false
o.joinspaces = true
o.fileencoding = 'UTF-8'
o.hlsearch = true
o.ignorecase = true
o.incsearch = true
o.shiftwidth = 2
o.shortmess = "Sc"
o.showmatch = true
o.smartindent = true
o.softtabstop = 2
o.tabstop = 2
o.termguicolors = true
o.splitbelow = true
o.splitright = true

vim.opt.fillchars:append { diff = "╱" }

-- Persistent undos
o.undofile = true
if sys.is_linux or sys.is_macos then
	o.undodir = os.getenv('HOME') .. '/.nvim/undo-dir'
elseif sys.is_windows then
	o.undodir = fn.stdpath('data') .. '\\undo-dir'
end

-- Keep undo history across sessions by storing it in a file
if fs.does_not_exist(o.undodir) and (sys.is_linux or sys.is_macos) then
	os.execute('mkdir -p' .. o.undodir .. '-m=0770')
elseif fs.does_not_exist(o.undodir) and sys.is_windows then
	os.execute('mkdir ' .. o.undodir)
end

-- Window Local
wo.number = true
wo.relativenumber = true
wo.wrap = true
o.foldmethod = 'expr'

-- Use treesitter for fold expressions
o.foldexpr = 'nvim_treesitter#foldexpr()'

-- Colorscheme
vim.g.base16colorspace = 256

-- Autocmd to set *.log files to type log
vim.api.nvim_create_autocmd({ "BufRead" }, {
	pattern = { "*.log" },
	callback = function() vim.bo.filetype = "log" end,
})

-- Get rid of search highlighting
nnoremap('<leader>c', ":nohl<CR>")

-- Close the quickfix
nnoremap('<leader>g', ":cclose<CR>")

-- Map ,e... to edit in new window, split, vertical, tab, from current directory.
nnoremap('<leader>ew', ':e <C-R>=expand("%:p:h") . "/" <CR>')
nnoremap('<leader>es', ':sp <C-R>=expand("%:p:h") . "/" <CR>')
nnoremap('<leader>ev', ':vsp <C-R>=expand("%:p:h") . "/" <CR>')

-- Kill all of the buffers except the current one
nnoremap('<leader>bo', ':w <bar> %bd <bar> e# <bar> bd# <CR>')

-- Map H,L to buffer change ( mimic tabs, but better )
map('n', '<C-j>', '<C-w><C-j>', { silent = true })
map('n', '<C-k>', '<C-w><C-k>', { silent = true })
map('n', '<C-l>', '<C-w><C-l>', { silent = true })
map('n', '<C-h>', '<C-w><C-h>', { silent = true })

-- Indent Blankline - Show indentation and what block your in
vim.opt.list = true

------------------------
-- LSP Plugin Configs --
-----------------------
vim.cmd [[cabbrev wq execute "Format sync" <bar> wq]]
