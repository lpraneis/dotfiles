local nnoremap = require 'maps'.nnoremap

return {
	{ 'rust-lang/rust.vim', lazy = true, ft = "rust" },
	{
		'mrcjkb/rustaceanvim',
		version = '^4', -- Recommended
		lazy = false, -- This plugin is already lazy
		init = function()
			vim.g.rustaceanvim = {
				-- Plugin configuration
				tools = {
				},
				-- LSP configuration
				server = {
					on_attach = function(client, bufnr)
						-- you can also put keymaps in here
					end,
					default_settings = {
						-- rust-analyzer language server configuration
						['rust-analyzer'] = {
						},
					},
				},
				-- DAP configuration
				dap = {
				},
			}
		end

	}
	-- 	{
	-- 		'simrat39/rust-tools.nvim',
	-- 		dependencies = { 'SmiteshP/nvim-navic', 'lukas-reineke/lsp-format.nvim' },
	-- 		config = function()
	-- 			local on_attach = function(client, bufnr)
	-- 				local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	-- 				require 'nvim-navic'.attach(client, bufnr)
	-- 				require "lsp-format".on_attach(client)
	--
	-- 				-- Mappings.
	-- 				local opts = { noremap = true, silent = true }
	--
	-- 				vim.keymap.set("n", "K", require 'rust-tools'.hover_actions.hover_actions, { buffer = bufnr })
	--
	-- 				buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	-- 				buf_set_keymap('n', 'go', '<cmd>RustOpenExternalDocs<CR>', opts)
	-- 				buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	-- 				buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	-- 				buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	-- 				buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	-- 				buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	-- 				buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	-- 				buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	-- 				buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
	-- 				buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
	-- 			end
	--
	-- 			local capabilities = require('cmp_nvim_lsp').default_capabilities()
	--
	-- 			require('rust-tools').setup({
	-- 				tools = {
	-- 					autoSetHints = true,
	-- 					runnables = {
	-- 						use_telescope = true
	-- 					},
	-- 				},
	-- 				capabilities = capabilities,
	-- 				server = {
	-- 					on_attach = on_attach,
	-- 					settings = {
	-- 						-- to enable rust-analyzer settings visit:
	-- 						-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
	-- 						["rust-analyzer"] = {
	-- 							-- enable clippy on save
	-- 							checkOnSave = {
	-- 								command = "clippy"
	-- 							},
	-- 							procMacro = {
	-- 								enable = true
	-- 							},
	--
	-- 							--  kind of annoying, but I can't find another way for rust lsp to work cross-target,
	-- 							--  so manually switch here if you want actual lsp context
	-- 							cargo = {
	-- 								-- Windows Target
	-- 								-- target = "x86_64-pc-windows-gnu"
	-- 								-- Linux Target
	-- 								-- target = "x86_64-unknown-linux-gnu"
	-- 								-- Mac Target
	-- 								-- target = "x86_64-apple-darwin"
	--
	-- 							},
	-- 						}
	-- 					}
	-- 				},
	-- 			})
	-- 			nnoremap('<leader>frr', '<cmd>RustRunnables<cr>')
	-- 			nnoremap('<leader>ft', '<cmd>RustTest<cr>')
	-- 			nnoremap('go', '<cmd>RustOpenExternalDocs<cr>')
	-- 		end,
	-- 		ft = "rust"
	-- 	},
}
