return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
	config = function()
		vim.keymap.set("n", "<leader>tr", function()
			require("trouble").toggle("workspace_diagnostics")
		end)
		vim.keymap.set("n", "<leader>rr", function()
			require("trouble").close()
		end)
		vim.keymap.set("n", "<leader>xq", function()
			require("trouble").toggle("quickfix")
		end)
		vim.keymap.set("n", "gR", function()
			require("trouble").toggle("lsp_references")
		end)
		vim.keymap.set("n", "[t", function()
			require("trouble").next({ skip_groups = true, jump = true })
		end)

		vim.keymap.set("n", "]t", function()
			require("trouble").previous({ skip_groups = true, jump = true })
		end)
	end,
}
