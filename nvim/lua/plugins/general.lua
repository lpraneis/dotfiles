return {
	{
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup({
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map('n', ']c', function()
						if vim.wo.diff then return ']c' end
						vim.schedule(function() gs.next_hunk() end)
						return '<Ignore>'
					end, { expr = true })

					map('n', '[c', function()
						if vim.wo.diff then return '[c' end
						vim.schedule(function() gs.prev_hunk() end)
						return '<Ignore>'
					end, { expr = true })

					-- Actions
					map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
					map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
					map('n', '<leader>hS', gs.stage_buffer)
					map('n', '<leader>hu', gs.undo_stage_hunk)
					map('n', '<leader>hR', gs.reset_buffer)
					map('n', '<leader>hp', gs.preview_hunk)
					map('n', '<leader>hb', function() gs.blame_line { opts = { full = true, extra_opts = { "-C" } } } end)
					map('n', '<leader>tb', gs.toggle_current_line_blame)
					map('n', '<leader>hd', gs.diffthis)
					map('n', '<leader>hD', function() gs.diffthis('~') end)
					map('n', '<leader>td', gs.toggle_deleted)
					map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
				end,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
					delay = 1000,
					ignore_whitespace = true,
					extra_opts = { "-C" },
					virt_text_priority = 100,
				},
			})
		end
	},
	{
		'lukas-reineke/indent-blankline.nvim',
		main = "ibl",
		config = function()
			require('ibl').setup()
		end
	},

	'qpkorr/vim-bufkill',
	{ 'kevinhwang91/nvim-hlslens', branch = 'main' },
	{ 'kylechui/nvim-surround',    config = true },
	{
		'MagicDuck/grug-far.nvim',
		config = function()
			require('grug-far').setup({});
		end
	},

}
