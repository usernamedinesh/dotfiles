return {
	{
		"rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup({
				compile = false, -- enable compiling the colorscheme
				undercurl = true, -- enable undercurls
				commentStyle = { italic = true },
				functionStyle = {},
				keywordStyle = { italic = true },
				statementStyle = { bold = true },
				typeStyle = {},
				transparent = true, -- do not set background color
				dimInactive = false, -- dim inactive window `:h hl-NormalNC`
				terminalColors = true, -- define vim.g.terminal_color_{0,17}
				colors = { -- add/modify theme and palette colors
					-- palette = {
					-- 	-- change all usages of these colors
					-- 	sumiInk0 = "#FFFFFF",
					-- 	fujiWhite = "#000000",
					-- },
					theme = {
						-- change specific usages for a certain theme, or for all of them
						wave = {
							ui = {
								float = {
									bg = "none",
								},
							},
						},
						dragon = {
							syn = {
								parameter = "yellow",
							},
						},
						all = {
							ui = {
								bg_gutter = "none",
							},
						},
					},
				},
				overrides = function(colors) -- add/modify highlights
					return {}
				end,
				--wave dragon lotus
				theme = "dargon", -- Load "wave" theme when 'background' option is not set
				background = { -- map the value of 'background' option to a theme
					dark = "wave", -- try "dragon" !
					light = "lotus",
				},
			})
			vim.cmd("colorscheme kanagawa")
		end,
	},

	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				disable_background = true,
				styles = {
					bold = true,
					italic = true,
					transparency = true,
				},
				enable = {
					terminal = true,
					legacy_highlights = true,
					migrations = true,
				},
			})
			-- vim.cmd("colorscheme rose-pine-main")
        	end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				terminal_colors = true, -- add neovim terminal colors
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = true,
					emphasis = true,
					comments = true,
					operators = false,
					folds = true,
				},
				strikethrough = true,
				invert_selection = true,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = false, -- invert background for search, diffs, statuslines and errors
				contrast = "hard", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {
					["@lsp.type.method"] = { bg = "#ff9900" },
				},
				dim_inactive = false,
				transparent_mode = true,
			})
			-- vim.cmd("colorscheme gruvbox")
		end,
	},

	{

		"Mofiqul/vscode.nvim",
		config = function()
			require("vscode").setup({
				transparent = true,
				italic_comments = true,
				underline_links = true,
				disable_nvimtree_bg = true,
				color_overrides = {
					vscLineNumber = "#FFFFFF",
				},
			})
			--
			-- vim.cmd.colorscheme("vscode")
		end,
	},
}
