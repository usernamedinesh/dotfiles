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
	{ "github/copilot.vim" },
	{ "eandrju/cellular-automaton.nvim" },
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
		"hoob3rt/lualine.nvim",
		config = function()
			require("lualine").setup({
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = {},
				},
			})
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
}
