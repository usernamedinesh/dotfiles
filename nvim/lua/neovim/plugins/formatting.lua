return {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufReadPost", "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	dependencies = {
		"williamboman/mason.nvim",
	},
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				["markdown.mdx"] = { "prettierd" },
				bash = { "shfmt" },
				css = { "prettierd" },
				fish = { "fish_indent" },
				go = { "goimports", "gofumpt" },
				graphql = { "prettierd" },
				html = { "prettierd" },
				javascript = { "prettierd" },
				javascriptreact = { "prettierd" },
				json = { "prettierd" },
				jsonc = { "prettierd" },
				less = { "prettierd" },
				lua = { "stylua" },
				markdown = { "prettierd" },
				sass = { "prettierd" },
				scss = { "prettierd" },
				sh = { "shfmt" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
				vue = { "prettierd" },
				yaml = { "prettierd" },
				zsh = { "shfmt" },
				python = { "isort", "black" },
			},
			formatters = {
				injected = { options = { ignore_errors = true } },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			},
			format_after_save = {
				lsp_fallback = true,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
