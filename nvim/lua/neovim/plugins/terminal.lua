local M = {
	"NvChad/nvterm",
	config = function()
		require("nvterm").setup()
		vim.api.nvim_set_keymap(
			"n",
			"<A-t>",
			'<cmd>lua require("nvterm.terminal").toggle("horizontal")<CR>',
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap("t", "jj", "<C-\\><C-n>", { noremap = true, silent = true })

		vim.api.nvim_set_keymap(
			"t",
			"<A-t>",
			'<cmd>lua require("nvterm.terminal").toggle("horizontal")<CR>',
			{ noremap = true, silent = true }
		)

		vim.api.nvim_set_keymap(
			"n",
			"<A-e>",
			'<cmd>lua require("nvterm.terminal").toggle("float")<CR>',
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"t",
			"<A-e>",
			'<cmd>lua require("nvterm.terminal").toggle("float")<CR>',
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<A-r>",
			'<cmd>lua require("nvterm.terminal").toggle("vertical")<CR>',
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"t",
			"<A-r>",
			'<cmd>lua require("nvterm.terminal").toggle("vertical")<CR>',
			{ noremap = true, silent = true }
		)
	end,
}

return M
