local nnoremap = require 'maps'.nnoremap
return {
	'nvim-lua/plenary.nvim',
	'nvim-lua/popup.nvim',
	{
		"rebelot/kanagawa.nvim",
		config = function()
			require('kanagawa').setup({
				commentStyle = { italic = false },
				keywordStyle = { italic = false },
				statementStyle = { bold = true },
				dimInactive = false, -- dim inactive window `:h hl-NormalNC`
				terminalColors = true, -- define vim.g.terminal_color_{0,17}
				colors = {
					-- add/modify theme and palette colors
					palette = {
						-- change background color
						sumiInk3 = "#121212",
						-- change line number, etc color
						sumiInk4 = "#121212",
					},
					theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
				},
				theme = "wave", -- Load "wave" theme when 'background' option is not set
				background = {
					-- map the value of 'background' option to a theme
					dark = "wave", -- try "dragon" !
					light = "lotus"
				},
			})
		end
	},
	{
		'folke/which-key.nvim',
		config = function()
			require("which-key").setup({
				plugins = {
					spelling = {
						enabled = true,
						suggestions = 20,
					}
				}
			})
		end
	},
	{
		'nvim-tree/nvim-tree.lua',
		config = function()
			require('nvim-tree').setup()
			nnoremap('<C-n>', ':NvimTreeToggle<CR>')
			nnoremap('<leader>r', ':NvimTreeRefresh<CR>')
		end
	},
	{
		'nvim-tree/nvim-web-devicons',
		config = function()
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
					},
					toml = {
						icon = ""
					}
				}
			}
		end
	},
	{
		'noib3/nvim-cokeline',
		config = function()
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
		end
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = 'SmiteshP/nvim-navic',
		config = function()
			local navic = require('nvim-navic')
			require('lualine').setup({
				options = { theme = 'onedark' },
				extensions = { 'nvim-tree' },
				sections = {
					lualine_c = { "navic" },
				},
			})
		end
	},
	{
		'petertriho/nvim-scrollbar',
		config = function()
			require("scrollbar").setup({
				handle = {
					color = '#b8b8b8',
				},
				handlers = {
					search = true,
				},
			})
		end
	},

	'yamatsum/nvim-cursorline',
	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xe",
				"<cmd>Trouble diagnostics filter.severity=vim.diagnostic.severity.ERROR<cr>",
				desc = "ERROR Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
			{
				"<leader>xi",
				"<cmd>Trouble lsp_implementations toggle<cr>",
				desc = "LSP Implementations List (Trouble)",
			},
			{
				"<leader>xc",
				"<cmd>Trouble toggle lsp_incoming_calls<cr>",
				desc = "LSP Callers (Trouble)",
			},
			{
				"<leader>xr",
				"<cmd>Trouble toggle lsp_references<cr>",
				desc = "LSP References (Trouble)",
			},
		},
		opts = {},
	},
	{ "folke/todo-comments.nvim", dependencies = "nvim-lua/plenary.nvim", config = true },
	{ 'NeogitOrg/neogit',         dependencies = 'nvim-lua/plenary.nvim', config = true },
	{
		'sindrets/diffview.nvim',
		dependencies = 'nvim-lua/plenary.nvim',
		config = function()
			require("diffview").setup({
				enhanced_diff_hl = true
			})
		end
	},
}
