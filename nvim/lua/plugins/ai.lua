return {
	{
		"nickjvandyke/opencode.nvim",
		version = "*",
		lazy = false,
		dependencies = {
			{
				"folke/snacks.nvim",
				optional = true,
				opts = {
					input = {},
					picker = {
						actions = {
							opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
						},
						win = {
							input = {
								keys = {
									["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
								},
							},
						},
					},
					terminal = {},
				},
			},
		},
		config = function()
			---@type opencode.Opts
			vim.g.opencode_opts = {
				provider = {
					enabled = "tmux",
				},
			}

			vim.o.autoread = true

			-- <C-.> Toggle opencode (same as sidekick toggle)
			vim.keymap.set({ "n", "t", "i", "x" }, "<C-.>", function() require("opencode").toggle() end,
				{ desc = "Toggle Opencode" })

			-- <leader>aa Toggle opencode CLI
			vim.keymap.set("n", "<leader>aa", function() require("opencode").toggle() end, { desc = "Opencode Toggle" })

			-- <leader>as Select action (prompts, commands, provider controls)
			vim.keymap.set("n", "<leader>as", function() require("opencode").select() end, { desc = "Opencode Select" })

			-- <leader>ad Detach / stop the opencode session
			vim.keymap.set("n", "<leader>ad", function() require("opencode").command("session.interrupt") end,
				{ desc = "Opencode Interrupt Session" })

			-- <leader>at Send this (range/selection/cursor position)
			vim.keymap.set({ "x", "n" }, "<leader>at", function() require("opencode").ask("@this: ", { submit = true }) end,
				{ desc = "Opencode Send This" })

			-- <leader>af Send file/buffer
			vim.keymap.set("n", "<leader>af", function() require("opencode").ask("@buffer: ", { submit = true }) end,
				{ desc = "Opencode Send File" })

			-- <leader>av Send visual selection
			vim.keymap.set("x", "<leader>av", function() require("opencode").ask("@this: ", { submit = true }) end,
				{ desc = "Opencode Send Selection" })

			-- <leader>ap Select prompt
			vim.keymap.set({ "n", "x" }, "<leader>ap", function() require("opencode").select() end,
				{ desc = "Opencode Select Prompt" })

			-- <leader>ao Toggle opencode (focused)
			vim.keymap.set("n", "<leader>ao", function() require("opencode").toggle() end, { desc = "Opencode Toggle (Focus)" })
		end,
	},
}
