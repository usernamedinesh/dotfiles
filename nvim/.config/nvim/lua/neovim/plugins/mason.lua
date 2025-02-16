return {
	"williamboman/mason.nvim",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	opts = {
		ui = {
			width = 0.8,
			height = 0.8,
			icons = {
				package_installed = "",
				package_pending = "",
				package_uninstalled = "",
			},
		},
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({})

		mason_lspconfig.setup({
			ensure_installed = {
				-- "tsserver",
				"lua_ls",
				-- "html",
				-- "cssls",
				-- "rust_analyzer",
				-- "templ",
				-- "gopls",
				"bashls",
				-- "eslint",
				-- "clangd",
				-- "jsonls",
				-- "tailwindcss",
				-- "yamlls",
				-- "emmet_ls",
			},
			automatic_installation = true,
		})

	end,
}
