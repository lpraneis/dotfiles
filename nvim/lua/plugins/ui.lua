local nnoremap = require 'maps'.nnoremap
return {
	'nvim-lua/plenary.nvim',
	'nvim-lua/popup.nvim',
	{ "rebelot/kanagawa.nvim", config = function()
		require('kanagawa').setup({
			commentStyle = { italic = false },
			keywordStyle = { italic = false },
			statementStyle = { bold = true },
			dimInactive = false, -- dim inactive window `:h hl-NormalNC`
			terminalColors = true, -- define vim.g.terminal_color_{0,17}
			colors = { -- add/modify theme and palette colors
				palette = {
					-- change background color
					sumiInk3 = "#121212",
					-- change line number, etc color
					sumiInk4 = "#121212",
				},
				theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
			},
			overrides = function(colors)
				local theme = colors.theme
				return {
					TelescopeTitle = { fg = theme.ui.special, bold = true },
					TelescopePromptNormal = { bg = theme.ui.bg_p1 },
					TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
					TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
					TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
					TelescopePreviewNormal = { bg = theme.ui.bg_dim },
					TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
				}
			end,
			theme = "wave", -- Load "wave" theme when 'background' option is not set
			background = { -- map the value of 'background' option to a theme
				dark = "wave", -- try "dragon" !
				light = "lotus"
			},
		})
	end
	},
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
