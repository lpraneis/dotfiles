return {
	{ 'lukas-reineke/lsp-format.nvim', config = function()
		require("lsp-format").setup {}
	end },
	{ 'neovim/nvim-lspconfig', dependencies = { { "williamboman/mason.nvim", config = function()
		require("mason").setup()
	end }, { "williamboman/mason-lspconfig.nvim", config = function()
		require("mason-lspconfig").setup {
			ensure_installed = { "lua_ls", "yamlls", "gopls" }
		}
	end },
		'SmiteshP/nvim-navic',
		'lukas-reineke/lsp-format.nvim'
	}, config = function()
		local on_attach = function(client, bufnr)
			local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
			require 'nvim-navic'.attach(client, bufnr)
			require "lsp-format".on_attach(client)

			-- Mappings.
			local opts = { noremap = true, silent = true }

			-- See `:help vim.lsp.*` for documentation on any of the below functions
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
		-- Add a go language server
		require 'lspconfig'.gopls.setup {
			on_attach = on_attach
		}

		-- YAML language server
		require 'lspconfig'.yamlls.setup {
			on_attach = on_attach
		}

		-- lua language server
		require 'lspconfig'.lua_ls.setup {
			on_attach = on_attach,
			settings = {
				Lua = {
					runtime = {
						-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
						version = 'LuaJIT',
					},
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { 'vim' },
					},
					workspace = {
						-- Make the server aware of Neovim runtime files
						library = vim.api.nvim_get_runtime_file("", true),
					},
					-- Do not send telemetry data containing a randomized but unique identifier
					telemetry = {
						enable = false,
					},
				},
			},
		}
	end },
	{ 'hrsh7th/cmp-nvim-lsp',                branch = 'main' },
	{ 'hrsh7th/cmp-nvim-lsp-signature-help', branch = 'main' },
	{ 'hrsh7th/cmp-buffer',                  branch = 'main' },
	{ 'hrsh7th/cmp-path',                    branch = 'main' },
	{ 'hrsh7th/cmp-cmdline',                 branch = 'main' },
	{ 'hrsh7th/nvim-cmp', branch = 'main', dependencies =

	'L3MON4D3/LuaSnip', config = function()
		local luasnip = require 'luasnip'
		local cmp = require 'cmp'
		cmp.setup({
			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
					luasnip.lsp_expand(args.body) -- For `luasnip` users.
					-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
					-- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
				end,
			},
			mapping = {
				['<C-p>'] = cmp.mapping.select_prev_item(),
				['<C-n>'] = cmp.mapping.select_next_item(),
				-- Add tab support
				['<S-Tab>'] = cmp.mapping.select_prev_item(),
				['<Tab>'] = cmp.mapping.select_next_item(),
				['<C-S-f>'] = cmp.mapping.scroll_docs( -4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.close(),
				['<CR>'] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Insert,
					select = true,
				})
			},
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'nvim_lsp_signature_help' },
				-- { name = 'vsnip' }, -- For vsnip users.
				{ name = 'luasnip' }, -- For luasnip users.
				-- { name = 'ultisnips' }, -- For ultisnips users.
				-- { name = 'snippy' }, -- For snippy users.
				{ name = 'buffer' },
			})
		})
	end
	},
	'saadparwaiz1/cmp_luasnip',
}
