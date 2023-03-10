local nnoremap = require 'maps'.nnoremap
return {
	'nvim-lua/plenary.nvim',
	'nvim-lua/popup.nvim',
	{ 'RRethy/nvim-base16', config = function()
		require('base16-colorscheme').setup({
			base00 = '#121212',
			base01 = '#353b45',
			base02 = '#3e4451',
			base03 = '#545862',
			base04 = '#565c64',
			base05 = '#abb2bf',
			base06 = '#b6bdca',
			base07 = '#c8ccd4',
			base08 = '#e06c75',
			base09 = '#d19a66',
			base0A = '#e5c07b',
			base0B = '#98c379',
			base0C = '#56b6c2',
			base0D = '#61afef',
			base0E = '#c678dd',
			base0F = '#be5046'
		})
	end },
	{ 'folke/which-key.nvim', config = function()
		require("which-key").setup({
			plugins = {
				spelling = {
					enabled = true,
					suggestions = 20,
				}
			}
		})
	end },
	{ 'nvim-tree/nvim-tree.lua', config = function()
		require('nvim-tree').setup()
		nnoremap('<C-n>', ':NvimTreeToggle<CR>')
		nnoremap('<leader>r', ':NvimTreeRefresh<CR>')
	end },
	{ 'nvim-tree/nvim-web-devicons', config = function()
		require('nvim-web-devicons').setup {
			override = {
				ps1 = {
					icon = "",
				},
				dockerfile = {
					icon = "",
				},
				Dockerfile = {
					icon = "",
				}
			}
		}
	end },
	{ 'noib3/nvim-cokeline', config = function()
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
		vim.api.nvim_set_keymap('n', 'H', '<Plug>(cokeline-focus-prev)', { silent = true })
		vim.api.nvim_set_keymap('n', 'L', '<Plug>(cokeline-focus-next)', { silent = true })
	end },
	{ 'nvim-lualine/lualine.nvim',
		dependencies = 'SmiteshP/nvim-navic',
		config = function()
			local navic = require('nvim-navic')
			require('lualine').setup({
				options = { theme = 'onedark' },
				extensions = { 'nvim-tree' },
				sections = {
					lualine_c = { 'filename', { navic.get_location, cond = navic.is_available } },
				},
			})
		end },
	{ 'petertriho/nvim-scrollbar', config = function()
		require("scrollbar").setup({
			handle = {
				color = '#b8b8b8',
			},
			handlers = {
				search = true,
			},
		})
	end },

	'yamatsum/nvim-cursorline',
	{ "folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup {}
			vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>",
				{ silent = true, noremap = true }
			)
		end
	},
	{ "folke/todo-comments.nvim", dependencies = "nvim-lua/plenary.nvim", config = true },
	{ 'TimUntersberger/neogit',   dependencies = 'nvim-lua/plenary.nvim', config = true },
	{ 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim', config = function()
		require("diffview").setup({
			enhanced_diff_hl = true
		})
	end },
}
