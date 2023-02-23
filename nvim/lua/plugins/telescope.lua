local nnoremap = require 'maps'.nnoremap

return {
	{ 'nvim-telescope/telescope.nvim', dependencies = { "nvim-telescope/telescope-ui-select.nvim", "nvim-lua/plenary.nvim" }, config = function()
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
					"--type-not swift",
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
		nnoremap('<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>')
		nnoremap('<leader>fs', '<cmd>lua require("telescope.builtin").live_grep()<cr>')
		nnoremap('<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>')
		nnoremap('<leader>fd', '<cmd>lua require("telescope.builtin").diagnostics()<cr>')
		nnoremap('<leader>fl', '<cmd>lua require("telescope.builtin").loclist()<cr>')
		nnoremap('<leader>fc', '<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<cr>')
		nnoremap('<leader>fw', '<cmd>lua require("telescope.builtin").lsp_workspace_symbols()<cr>')
		nnoremap('<leader>fgc', '<cmd>lua require("telescope.builtin").git_commits()<cr>')
		nnoremap('<leader>fgs', '<cmd>lua require("telescope.builtin").git_status()<cr>')
		nnoremap('<leader>fgb', '<cmd>lua require("telescope.builtin").git_bcommits()<cr>')
		nnoremap('gr', '<cmd>lua require("telescope.builtin").lsp_references()<cr>')
		nnoremap('gi', '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>')
		nnoremap('gd', '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>')
	end },
}
