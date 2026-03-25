return {
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		config = function()
			-- NOTE: Tree sitter is dumb, so the highlights.scm file should manually be symlinked
			-- to a version in a checked-out version of this repo.
			local parsers = require("nvim-treesitter.parsers")
			parsers.tracinglog = {
				install_info = {
					url = "https://github.com/lpraneis/tree-sitter-tracing-log",
					files = { "src/parser.c" },
					branch = "main",
					generate_requires_npm = false,
					requires_generate_from_grammar = true,
				},
			}
			vim.filetype.add({ extension = { log = "tracinglog" } })

			-- In the new nvim-treesitter, highlighting is built into Neovim.
			-- Enable treesitter highlighting for all filetypes via autocmd.
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					pcall(vim.treesitter.start, args.buf)
				end,
			})

			-- Ensure parsers are installed (async, won't block startup)
			local ensure_installed = { "rust", "c", "markdown", "markdown_inline",
				"lua", "html", "http", "json", "json5", "latex",
				"llvm", "make",
				"regex", "toml", "yaml", "comment", "dockerfile", "tracinglog", "go", "vim", "vimdoc", "query" }
			require("nvim-treesitter.install").ensure_installed(ensure_installed)
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
	{ 'nvim-treesitter/nvim-treesitter-textobjects', branch = "main" }
}
