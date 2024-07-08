return {
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		config = function()
			-- NOTE: Tree sitter is dumb, so the highlights.scm file should manually be symlinked
			-- to a version in a checked-out version of this repo.
			local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
			parser_config.tracinglog = {
				install_info = {
					url = "https://github.com/lpraneis/tree-sitter-tracing-log",
					-- url = "~/tools/tree-sitter-tracing-log",
					files = { "src/parser.c" },
					-- optional entries:
					branch = "main",
					generate_requires_npm = false,
					requires_generate_from_grammar = true,
				},
				filetype = "log",
			}
			require('nvim-treesitter.configs').setup {
				ensure_installed = { "rust", "c", "markdown", "markdown_inline",
					"lua", "html", "http", "json", "json5", "latex",
					"llvm", "make",
					"regex", "toml", "yaml", "comment", "dockerfile", "tracinglog", "go", "vim", "vimdoc", "query" },
				highlight = {
					enable = true,
				},
			}
		end
	},
	{
		'm-demare/hlargs.nvim',
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require('hlargs').setup {
				extras = {
					named_parameters = true,
				}
			}
		end
	},
}
