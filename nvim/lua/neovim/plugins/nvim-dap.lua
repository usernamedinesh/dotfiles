local M = {
	"leoluz/nvim-dap-go",
	ft = "go",
	dependencies = "mfussenegger/nvim-dap",
}

function M.config(_, opts)
	require("dap-go").setup(opts)
	vim.keymap.set(
		"n",
		"<leader>db",
		"<cmd>DapToggleBreakpoint<CR>",
		{ silent = true, desc = "Add breakpoint at line" }
	)
	vim.keymap.set(
		"n",
		"<leader>du",
		"<cmd>lua require('dap.ui.widgets').sidebar(require('dap.ui.widgets').scopes).open()<CR>",
		{ silent = true, desc = "Toggle sidebar" }
	)
	--open the menu
	vim.keymap.set("n", "<leader>dh", "<cmd>lua require('dap').continue()<CR>", { silent = true, noremap = true })
	-- start debuging
	vim.keymap.set("n", "<leader>dj", "<cmd>lua require('dap-go').debug_test()<CR>", { silent = true, noremap = true })
	-- start the last debug test
	vim.keymap.set(
		"n",
		"<leader>dk",
		"<cmd>lua require('dap-go').debug_last_test()<CR>",
		{ silent = true, noremap = true }
	)
end

return M
