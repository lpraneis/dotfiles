local lsp_on_attach = function(client, bufnr)
	require 'nvim-navic'.attach(client, bufnr)
	require "lsp-format".on_attach(client)

	vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
	vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
end

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		local opts = { buffer = ev.buf }
		local tele = require("telescope.builtin")


		-- Signature help
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

		-- Toggle Inlay Hints ( off by default )
		vim.keymap.set('n', '<space>i', function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, opts)

		-- goto
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)

		-- telescope goto references / implementations / symbols
		vim.keymap.set('n', 'gr', tele.lsp_references, opts)
		vim.keymap.set('n', 'gi', tele.lsp_implementations, opts)
		vim.keymap.set('n', '<leader>fw', tele.lsp_workspace_symbols, opts)

		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
	end
})

return {
	lsp_on_attach = lsp_on_attach
}
