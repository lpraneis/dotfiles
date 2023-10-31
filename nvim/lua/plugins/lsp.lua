return {
	{ 'lukas-reineke/lsp-format.nvim',       config = true },
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			-- mason helps auto-install unimportant LSP
			{ "williamboman/mason.nvim",      config = true },
			{
				"williamboman/mason-lspconfig.nvim",
				opts = {
					ensure_installed = { "lua_ls", "yamlls", "gopls", "pyright", "powershell_es" } }
			},
			{ 'SmiteshP/nvim-navic' },
			{ 'lukas-reineke/lsp-format.nvim' }
		},
		config = function()
			local on_attach = function(client, bufnr)
				local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
				require 'nvim-navic'.attach(client, bufnr)
				require "lsp-format".on_attach(client)

				-- Mappings.
				local opts = { noremap = true, silent = true }

				buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
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

			-- Go language server
			require 'lspconfig'.gopls.setup {
				on_attach = on_attach
			}

			-- YAML language server
			require 'lspconfig'.yamlls.setup {
				on_attach = on_attach
			}

			-- Powershell language server
			require 'lspconfig'.powershell_es.setup {
				on_attach = on_attach
			}

			-- Python language server
			require 'lspconfig'.pyright.setup {
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
						telemetry = {
							enable = false,
						},
					},
				},
			}
		end
	},
	{ 'hrsh7th/cmp-nvim-lsp',                branch = 'main' },
	{ 'hrsh7th/cmp-nvim-lsp-signature-help', branch = 'main' },
	{ 'hrsh7th/cmp-buffer',                  branch = 'main' },
	{ 'hrsh7th/cmp-path',                    branch = 'main' },
	{ 'hrsh7th/cmp-cmdline',                 branch = 'main' },
	{
		'hrsh7th/nvim-cmp',
		branch = 'main',
		config = function()
			local luasnip = require 'luasnip'
			local cmp = require 'cmp'
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				mapping = {
					['<C-p>'] = cmp.mapping.select_prev_item(),
					['<C-n>'] = cmp.mapping.select_next_item(),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
							-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
							-- that way you will only jump inside the snippet region
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
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
					{ name = 'luasnip' }, -- For luasnip users.
					{ name = 'buffer' },
				})
			})
		end
	},
	'saadparwaiz1/cmp_luasnip',
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			local ls = require 'luasnip'
			vim.keymap.set({ "i", "s" }, "<C-i>", function() ls.jump(1) end, { silent = false })
			vim.keymap.set({ "i", "s" }, "<C-o>", function() ls.jump(-1) end, { silent = true })

			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip").filetype_extend("rust", { "rustdoc" })
		end
	},
}
