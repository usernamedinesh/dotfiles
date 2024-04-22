return {
	{ "kevinhwang91/nvim-bqf", ft = "qf" },
	{ "junegunn/fzf.vim" },
	{
		"junegunn/fzf",
		build = "./install --all",
		run = function()
			vim.fn["fzf#install"]()
		end,
	},
	{ "tpope/vim-fugitive" },
	-- { "github/copilot.vim" },
	{ "eandrju/cellular-automaton.nvim" },
	{
		"nvim-lua/plenary.nvim",
		name = "plenary",
	},

	{
		"terryma/vim-multiple-cursors",
		-- "mg979/vim-visual-multi",
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
		end,
	},
	{
		"numToStr/Comment.nvim",
		lazy = false,
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"rust-lang/rust.vim",
		ft = "rust",
		init = function()
			vim.g.rustfmt_autosave = 1
		end,
	},

	{
		"stevearc/dressing.nvim",
		opts = true,
		config = function()
			local dressing = require("dressing")
			dressing.setup({
				-- Options will go here
			})
		end,
	},

	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
				-- surr*ound_words             ysiw)           (surround_words)
				--     *make strings               ys$"            "make strings"
				--     [delete ar*ound me!]        ds]             delete around me!
				--     remove <b>HTML t*ags</b>    dst             remove HTML tags
				--     'change quot*es'            cs'"            "change quotes"
				--     <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
				--     delete(functi*on calls)     dsf             function calls
				--
			})
		end,
	},

	{
		"laytan/cloak.nvim",
		config = function()
			require("cloak").setup({
				enabled = true,
				cloak_character = "*",
				highlight_group = "Comment",
				patterns = {
					{
						file_pattern = {
							".env*",
							"wrangler.toml",
							".dev.vars",
						},
						cloak_pattern = "=.+",
					},
				},
			})
		end,
	},

	{
		-- end,
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"meuter/lualine-so-fancy.nvim",
		},
		enabled = true,
		lazy = false,
		event = { "BufReadPost", "BufNewFile", "VeryLazy" },
		config = function()
			-- local icons = require("config.icons")
			require("lualine").setup({
				options = {
					theme = "auto",
					component_separators = { left = "|", right = "|" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = {
						"fancy_branch",
					},
					lualine_c = {
						{
							"filename",
							path = 1, -- 2 for full path
							symbols = {
								modified = "  ",
								-- readonly = "  ",
								-- unnamed = "  ",
							},
						},
					},
					lualine_y = {},
					lualine_z = {},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					-- lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				extensions = { "neo-tree", "lazy" },
			})
		end,
	},

	-- Smooth scrolling neovim plugin written in lua

	{
		"karb94/neoscroll.nvim",
		config = function()
			local neoscroll = require("neoscroll")
			local config = require("neoscroll.config")

			-- Define the custom mappings
			local mappings = {}
			mappings["<S-c>"] = { "scroll", { "-vim.wo.scroll", "true", "350", "sine", [['cursorline']] } }
			mappings["<S-m>"] = { "scroll", { "vim.wo.scroll", "true", "350", "sine", [['cursorline']] } }
			config.set_mappings(mappings)

			-- Setup neoscroll with options
			neoscroll.setup({})
		end,
	},

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")

			harpoon:setup()

			vim.keymap.set("n", "<leader>a", function()
				harpoon:list():add()
			end)
			vim.keymap.set("n", "<C-h>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)

			vim.keymap.set("n", "<C-i>", function()
				harpoon:list():select(1)
			end)
			vim.keymap.set("n", "<C-o>", function()
				harpoon:list():select(2)
			end)
			vim.keymap.set("n", "<C-l>", function()
				harpoon:list():select(3)
			end)
			vim.keymap.set("n", "<C-'>", function()
				harpoon:list():select(4)
			end)

			-- Toggle previous & next buffers stored within Harpoon list
			vim.keymap.set("n", "<A-i>", function()
				harpoon:list():prev()
			end)
			vim.keymap.set("n", "<A-o>", function()
				harpoon:list():next()
			end)
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		config = function()
			require("noice").setup({
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = false, --set true to top
					long_message_to_split = false, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = true, -- add a border to hover docs and signature help
				},
				lsp = {
					progress = {
						enabled = false, --disable  lsp message when first load
					},
				},
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},
	-- breadcrumbs
	{
		"LunarVim/breadcrumbs.nvim",
		config = function()
			require("breadcrumbs").setup()
		end,
	},
	-- Simple winbar/statusline plugin that shows your current code context
	{
		"SmiteshP/nvim-navic",
		config = function()
			local icons = require("neovim.core.icons")
			require("nvim-navic").setup({
				highlight = true,
				lsp = {
					auto_attach = true,
					preference = { "typescript-tools" },
				},
				click = true,
				separator = " " .. icons.ui.ChevronRight .. " ",
				depth_limit = 0,
				depth_limit_indicator = "..",
				icons = {
					File = " ",
					Module = " ",
					Namespace = " ",
					Package = " ",
					Class = " ",
					Method = " ",
					Property = " ",
					Field = " ",
					Constructor = " ",
					Enum = " ",
					Interface = " ",
					Function = " ",
					Variable = " ",
					Constant = " ",
					String = " ",
					Number = " ",
					Boolean = " ",
					Array = " ",
					Object = " ",
					Key = " ",
					Null = " ",
					EnumMember = " ",
					Struct = " ",
					Event = " ",
					Operator = " ",
					TypeParameter = " ",
				},
			})
		end,
	},
}
