local nnoremap = require 'maps'.nnoremap

return {
	{ 'rust-lang/rust.vim',    lazy = true, ft = "rust" },
	{ 'mfussenegger/nvim-dap', lazy = true, ft = "rust" },
	{ "rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("dapui").setup({
				icons = { expanded = "▾", collapsed = "▸" },
				mappings = {
					-- Use a table to apply multiple mappings
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
					toggle = "t",
				},
				-- Expand lines larger than the window
				-- Requires >= 0.7
				expand_lines = vim.fn.has("nvim-0.7"),
				-- Layouts define sections of the screen to place windows.
				-- The position can be "left", "right", "top" or "bottom".
				-- The size specifies the height/width depending on position. It can be an Int
				-- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
				-- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
				-- Elements are the elements shown in the layout (in order).
				-- Layouts are opened in order so that earlier layouts take priority in window sizing.
				layouts = {
					{
						elements = {
							-- Elements can be strings or table with id and size keys.
							{ id = "scopes", size = 0.25 },
							"breakpoints",
							"stacks",
							"watches",
						},
						size = 40, -- 40 columns
						position = "left",
					},
					{
						elements = {
							"repl",
							"console",
						},
						size = 0.25, -- 25% of total lines
						position = "bottom",
					},
				},
				floating = {
					max_height = nil, -- These can be integers or a float between 0 and 1.
					max_width = nil, -- Floats will be treated as percentage of your screen.
					border = "single", -- Border style. Can be "single", "double" or "rounded"
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				windows = { indent = 1 },
				render = {
					max_type_length = nil, -- Can be integer or nil.
				}
			})

			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.after.event_initialized["dapui_config"] = function()
				-- Set V to inspect variable under cursor
				vim.api.nvim_set_keymap("n", "V", '<Cmd>lua require("dapui").eval()<CR>',
					{ silent = true, noremap = true }
				)
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				-- Remove V mapping on dap exit
				vim.api.nvim_del_keymap("n", "V")
				dapui.close()
			end
		end, ft = "rust" },
	{ 'simrat39/rust-tools.nvim',
		dependencies = { 'SmiteshP/nvim-navic', 'lukas-reineke/lsp-format.nvim' },
		config = function()
			local on_attach = function(client, bufnr)
				local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
				require 'nvim-navic'.attach(client, bufnr)
				require "lsp-format".on_attach(client)

				-- Mappings.
				local opts = { noremap = true, silent = true }

				vim.keymap.set("n", "K", require 'rust-tools'.hover_actions.hover_actions, { buffer = bufnr })

				buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
				buf_set_keymap('n', 'go', '<cmd>RustOpenExternalDocs<CR>', opts)
				buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
				buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
				buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
				buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
				buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
				buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
				buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
				buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
				buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
			end

			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			local dap_extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.7.4/'
			local dap_codelldb_path = dap_extension_path .. 'adapter/codelldb'
			local dap_liblldb_path = dap_extension_path .. 'lldb/lib/liblldb.so'

			require('rust-tools').setup({
				tools = {
					autoSetHints = true,
					runnables = {
						use_telescope = true
					},
				},
				capabilities = capabilities,
				server = {
					on_attach = on_attach,
					settings = {
						-- to enable rust-analyzer settings visit:
						-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
						["rust-analyzer"] = {
							-- enable clippy on save
							checkOnSave = {
								command = "clippy"
							},

							--  kind of annoying, but I can't find another way for rust lsp to work cross-target,
							--  so manually switch here if you want actual lsp context
							cargo = {
								-- Windows Target
								-- target = "x86_64-pc-windows-gnu"
								-- Linux Target
								-- target = "x86_64-unknown-linux-gnu"
								-- Mac Target
								-- target = "x86_64-apple-darwin"

							},
						}
					}
				},
				dap = {
					adapter = require('rust-tools.dap').get_codelldb_adapter(
						dap_codelldb_path, dap_liblldb_path)
				}
			})
			nnoremap('<leader>fr', '<cmd>RustRunnables<cr>')
			nnoremap('<leader>ft', '<cmd>RustTest<cr>')
			nnoremap('go', '<cmd>RustOpenExternalDocs<cr>')
		end,
		ft = "rust" },
}
