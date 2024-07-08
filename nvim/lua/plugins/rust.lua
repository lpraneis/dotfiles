local lsp_on_attach = require("lspbindings").lsp_on_attach

return {
	{ 'rust-lang/rust.vim', lazy = true, ft = "rust" },
	{
		'saecki/crates.nvim',
		event = { "BufRead Cargo.toml" },
		config = function()
			require('crates').setup()
			local crates = require("crates")
			local opts = { silent = true }

			vim.keymap.set("n", "<leader>ct", crates.toggle, opts)
			vim.keymap.set("n", "<leader>cr", crates.reload, opts)

			vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, opts)
			vim.keymap.set("n", "<leader>cf", crates.show_features_popup, opts)
			vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, opts)

			vim.keymap.set("n", "<leader>cu", crates.update_crate, opts)
			vim.keymap.set("v", "<leader>cu", crates.update_crates, opts)
			vim.keymap.set("n", "<leader>ca", crates.update_all_crates, opts)
			vim.keymap.set("n", "<leader>cU", crates.upgrade_crate, opts)
			vim.keymap.set("v", "<leader>cU", crates.upgrade_crates, opts)
			vim.keymap.set("n", "<leader>cA", crates.upgrade_all_crates, opts)

			vim.keymap.set("n", "<leader>cx", crates.expand_plain_crate_to_inline_table, opts)
			vim.keymap.set("n", "<leader>cX", crates.extract_crate_into_table, opts)

			vim.keymap.set("n", "<leader>cH", crates.open_homepage, opts)
			vim.keymap.set("n", "<leader>cR", crates.open_repository, opts)
			vim.keymap.set("n", "<leader>cD", crates.open_documentation, opts)
			vim.keymap.set("n", "<leader>cC", crates.open_crates_io, opts)
		end,
	},
	{
		'mrcjkb/rustaceanvim',
		version = '^4', -- Recommended
		lazy = false, -- This plugin is already lazy
		init = function()
			--
			vim.g.rustaceanvim = {
				-- Plugin configuration
				tools = {
					test_executor = 'background'
				},
				-- LSP configuration
				server = {
					on_attach = function(client, bufnr)
						-- call the top-level on-attach function
						lsp_on_attach(client, bufnr)
						local opts = { silent = true, buffer = bufnr }

						-- open external docs in browser
						vim.keymap.set("n", "go", function() vim.cmd.RustLsp('externalDocs') end, opts)
						-- render cargo build diagnostics inline
						vim.keymap.set("n", "<space>d", function() vim.cmd.RustLsp('renderDiagnostic') end, opts)

						-- Override hover with rust-analyzer's hover actions
						vim.keymap.set("n", "K", function() vim.cmd.RustLsp({ 'hover', 'actions' }) end, opts)
						-- Override code actions with rust-analyzer's code actions
						vim.keymap.set("n", "<space>a", function() vim.cmd.RustLsp('codeAction') end, opts)
						vim.keymap.set("n", "<leader>frr", function() vim.cmd.RustLsp('runnables') end, opts)
						vim.keymap.set("n", "<leader>ft", function() vim.cmd.RustLsp('testables') end, opts)
					end,
					default_settings = {
						-- rust-analyzer language server configuration
						-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
						['rust-analyzer'] = {
							checkOnSave = {
								command = "clippy"
							},
							procMacro = {
								enable = true
							},
							--  kind of annoying, but I can't find another way for rust lsp to work cross-target,
							--  so manually switch here if you want actual lsp context
							--  cargo.allTargets doesn't seem to work?
							cargo = {
								-- Windows Target
								-- target = "x86_64-pc-windows-gnu"
								-- Linux Target
								-- target = "x86_64-unknown-linux-gnu"
								-- Mac Target
								-- target = "x86_64-apple-darwin"

							},
						},
					},
				},
				-- DAP configuration
				dap = {
				},
			}
		end

	}
}
