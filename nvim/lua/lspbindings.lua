local lsp_on_attach = function(client, bufnr)
	require 'nvim-navic'.attach(client, bufnr)
	require "lsp-format".on_attach(client)

	vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
	vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

	-- Work around https://github.com/neovim/neovim/issues/30985
	for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
		local default_diagnostic_handler = vim.lsp.handlers[method]
		vim.lsp.handlers[method] = function(err, result, context, config)
			if err ~= nil and err.code == -32802 then
				return
			end
			return default_diagnostic_handler(err, result, context, config)
		end
	end
end

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		local opts = { buffer = ev.buf }
		-- Signature help
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		-- Actions
		vim.keymap.set('n', '<space>a', vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })
	end
})

return {
	lsp_on_attach = lsp_on_attach
}
