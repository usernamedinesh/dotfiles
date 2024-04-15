local M = {
	"folke/todo-comments.nvim",
	requires = { "nvim-lua/plenary.nvim" },
	opts = {},
}

function M.config()
	-- local todo_comments = require("todo-comments")
	require("todo-comments").setup()
	vim.keymap.set("n", "<leader>tj", "<cmd>TodoTelescope<cr>")
	vim.keymap.set("n", "<leader>th", "<cmd>TodoTrouble<cr>")
	vim.keymap.set("n", "<leader>tn", "<cmd>TodoLocList<cr>")
	vim.keymap.set("n", "<leader>tl", "<cmd>TodoQuickFix<cr>")

	-- vim.keymap.set("n", "<C-j>", function()
	-- 	require("todo-comments").jump_next()
	-- end, { noremap = true, silent = true, desc = "Next todo comment" })
	--
	-- vim.keymap.set("n", "<C-k>", function()
	-- 	require("todo-comments").jump_prev()
	-- end, { noremap = true, silent = true, desc = "Previous todo comment" })
end
return M

-- TODO: lets do this later
-- FIX: need to be fixc
-- HACK: weried code warning
-- PERF: fully optiomized
-- NOTE: this is a node
-- WARNING: this is a warning
-- TODO: lets do thisokey
