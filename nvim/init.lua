require('impatient')
----------------
-- Local imports
----------------
package.path = package.path .. ";/home/lpraneis/tools/dotfiles/nvim/lua/?.lua"
local sys = require('sys')
local maps = require('maps')
local fs = require('fs')


local execute = vim.api.nvim_command
local fn = vim.fn
local o = vim.o
local wo = vim.wo
local bo = vim.bo

local nmap = maps.nmap
local nnoremap = maps.nnoremap
local noremap = maps.noremap
local vmap = maps.vmap
local vnoremap = maps.vnoremap

local map = vim.api.nvim_set_keymap

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then 
	packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function()
	use {
		'wbthomason/packer.nvim',
		'neovim/nvim-lsp',
		'nvim-lua/plenary.nvim',
		'nvim-lua/popup.nvim',
		'neovim/nvim-lspconfig',
		'nvim-telescope/telescope-ui-select.nvim',
		'nvim-telescope/telescope.nvim',
		'rust-lang/rust.vim',
		'simrat39/rust-tools.nvim',
		'laggardkernel/vim-one',
		'RRethy/nvim-base16',
		'lewis6991/impatient.nvim',
		'folke/which-key.nvim',
		'folke/zen-mode.nvim',
		'kevinhwang91/nvim-hlslens',
		'kyazdani42/nvim-tree.lua',
		'kyazdani42/nvim-web-devicons',
		'lewis6991/gitsigns.nvim',
		'm-demare/hlargs.nvim',
		'noib3/nvim-cokeline',
		'numToStr/Comment.nvim',
		'nvim-lualine/lualine.nvim',
		'petertriho/nvim-scrollbar',
		'yamatsum/nvim-cursorline',
		'SmiteshP/nvim-gps',
		'lukas-reineke/indent-blankline.nvim',
		'qpkorr/vim-bufkill',
		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip',
	}
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}
	use {'hrsh7th/cmp-nvim-lsp', branch= 'main'}
	use {'hrsh7th/cmp-buffer',  branch= 'main'}
	use {'hrsh7th/cmp-path', branch= 'main'}
	use {'hrsh7th/cmp-cmdline', branch= 'main'}
	use {'hrsh7th/nvim-cmp', branch= 'main'}
	if packer_bootstrap then
		require('packer').sync()
	end
end)

-- Global
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
o.shortmess="Sc"
o.showmatch = true
o.smartindent = true
o.softtabstop = 2
o.tabstop = 2
o.termguicolors = true
o.splitbelow = true
o.splitright = true

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
wo.colorcolumn='101'
wo.number = true
wo.relativenumber = true
wo.wrap = true
o.foldmethod = 'expr'
o.foldexpr='nvim_treesitter#foldexpr()'

-- Colorscheme
vim.g.base16colorspace = 256
vim.cmd('filetype plugin indent on')

-- Autocmd
vim.cmd('autocmd BufWritePost plugins.lua PackerCompile')
vim.cmd('autocmd BufRead,BufNewFile *.md,*.txt setlocal spell spelllang=en_us')
vim.cmd('autocmd BufRead * normal zR')

-- Shortcuts
vim.g.mapleader=','

-- Get rid of search highlighting
nnoremap('<leader>c', ":nohl<CR>")

-- Map ,e... to edit in new window, split, vertical, tab, from current directory.
nnoremap('<leader>ew', ':e <C-R>=expand("%:p:h") . "/" <CR>')
nnoremap('<leader>es', ':sp <C-R>=expand("%:p:h") . "/" <CR>')
nnoremap('<leader>ev', ':vsp <C-R>=expand("%:p:h") . "/" <CR>')

-- Kill all of the buffers except the current one
nnoremap('<leader>bo', ':w <bar> %bd <bar> e# <bar> bd# <CR>')

----------------
-- Plugin Configurations
----------------
require('base16-colorscheme').setup({
	base00 = '#181818', base01 = '#353b45', base02 = '#3e4451', base03 = '#545862',
	base04 = '#565c64', base05 = '#abb2bf', base06 = '#b6bdca', base07 = '#c8ccd4',
	base08 = '#e06c75', base09 = '#d19a66', base0A = '#e5c07b', base0B = '#98c379',
	base0C = '#56b6c2', base0D = '#61afef', base0E = '#c678dd', base0F = '#be5046'
})
require('nvim-tree').setup()
nnoremap('<C-n>', ':NvimTreeToggle<CR>')
nnoremap('<leader>r', ':NvimTreeRefresh<CR>')

-- Telescope!
require('telescope').setup {
	defaults = {
		mappings = {
			i = {
				["<C-h>"] = "which_key"
			}
		},
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case"
		}
	},
	pickers = {
		buffers = {
			mappings = {
				n = {
					["d"] = function(prompt_bufnr)
						require("telescope.actions").delete_buffer(prompt_bufnr)
					end
				},
				i = {
					["<C-b>"] = function(prompt_bufnr)
						require("telescope.actions").delete_buffer(prompt_bufnr)
					end
				}
			}
		}
	},
	 extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
      }
    }
  }

}

require('telescope').load_extension('ui-select')

tb = require('telescope.builtin')
nnoremap('<leader>ff', '<cmd>lua tb.find_files()<cr>')
nnoremap('<leader>fs', '<cmd>lua tb.live_grep()<cr>')
nnoremap('<leader>fb', '<cmd>lua tb.buffers()<cr>')
nnoremap('<leader>fgc', '<cmd>lua tb.git_commits()<cr>')
nnoremap('<leader>fgs', '<cmd>lua tb.git_status()<cr>')
nnoremap('<leader>fgb', '<cmd>lua tb.git_bcommits()<cr>')
nnoremap('<leader>fr', '<cmd>lua tb.lsp_references()<cr>')

-- NvimTree - File navigator sidebar
require('nvim-tree').setup()
nnoremap('<C-n>', ':NvimTreeToggle<CR>')
nnoremap('<leader>r', ':NvimTreeRefresh<CR>')

-- Which Key - Helpful pop up of what keybindings exist
require("which-key").setup( {
	plugins = {
		spelling = {
			enabled = true,
			suggestions = 20,
		}
	}
})

-- Nvim GPS - status line component to show where you are in a file
require("nvim-gps").setup()
local gps = require("nvim-gps")

-- Lualine - status line plugin
require('lualine').setup({
	options = { theme = 'onedark'},
	extensions = {'nvim-tree'},
	sections = {
		lualine_c = {'filename', { gps.get_location, cond = gps.is_available } },
	},
})
-- Cokeline - Bufferbar plugin
require('cokeline').setup({
	sidebar = {
		filetype = 'NvimTree',
		components = {
			{
				text = '  NvimTree',
				style = 'bold',
			},
		}
	},
})
-- Map H,L to buffer change ( mimic tabs, but better )
map('n', 'H', '<Plug>(cokeline-focus-prev)', {silent = true})
map('n', 'L', '<Plug>(cokeline-focus-next)', {silent = true})

-- Indent Blankline - Show indentation and what block your in
vim.opt.list = true
require('indent_blankline').setup({
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
})

-- NVIM TreeSitter - Treesitter configs
require('nvim-treesitter.configs').setup {
	ensure_installed = {"rust", "c", "markdown", "lua", "cpp", "html", "http", "json", "json5", "latex", "llvm", "make", "regex", "toml", "yaml"},
	highlight = {
		enable = true,
	},
}

-- hlargs - Highlight function args using treesitter
require('hlargs').setup()


-- Zen Mode - Have a moment of zen when writing
require("zen-mode").setup()

-- Scrollbar - Add a scroll bar to neovim
require("scrollbar").setup({
	handle = {
		color = '#b8b8b8',
	},
	handlers = {
		search = true,
	},
})
-- Comment - Comment keymaps for extra powers on what to comment out
require('Comment').setup()

require('telescope').setup {
	defaults = {
		mappings = {
			i = {
				["<C-h>"] = "which_key"
			}
		},
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case"
		}
	},
	pickers = {
		buffers = {
			mappings = {
				n = {
					["d"] = function(prompt_bufnr)
						require("telescope.actions").delete_buffer(prompt_bufnr)
					end
				},
				i = {
					["<C-b>"] = function(prompt_bufnr)
						require("telescope.actions").delete_buffer(prompt_bufnr)
					end
				}
			}
		}
	}

}
------------------------
-- LSP Plugin Configs --
-----------------------
require('lsp')

------------------------
-- Vim Plugin Configs --
------------------------
vim.g.rustfmt_autosave = 1
