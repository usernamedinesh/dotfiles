local M = {
	"nvim-telescope/telescope.nvim",
    --  {
    --     'nvim-telescope/telescope-fzf-native.nvim',
    --     build = 'make',
    -- },
         dependencies = {
		  "nvim-lua/plenary.nvim",
		{ "ThePrimeagen/git-worktree.nvim" },
	},
}

function M.config()
    require("telescope").setup({
        pickers = {
            colorscheme = {
                enable_preview = true,
            },
        },
    })
	local telescope = require("telescope")

	local builtin = require("telescope.builtin")
	require("telescope").load_extension("git_worktree")

	pcall(require("telescope").load_extension, "fzf")

	-- set keymaps
	local keymap = vim.keymap

	vim.keymap.set("n", "<leader>?", function()
		require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
			winblend = 10,
			previewer = false,
		}))
	end, { desc = "[/] Fuzzily search in current buffer]" })

	keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
	keymap.set("n", "<leader>cf", "<cmd>Telescope colorscheme<cr>", { desc = "change colorshceme" })
	keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
	vim.keymap.set("n", "<C-p>", builtin.git_files, {})
	vim.keymap.set("n", "<leader>pw", function()
		local word = vim.fn.expand("<cword>")
		builtin.grep_string({ search = word })
	end)
	vim.keymap.set("n", "<leader>pm", function()
		local word = vim.fn.expand("<cWORD>")
		builtin.grep_string({ search = word })
	end)
	keymap.set(
		"n",
		"<leader>fa",
		"<cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>",
		{ desc = "Find all" }
	)
	keymap.set(
		"n",
		"<leader>fw",
		"<cmd> Telescope current_buffer_fuzzy_find<cr>",
		{ desc = "Find string under cursor in cwd" }
	)
	keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "find buffers" })
	vim.keymap.set("n", "<leader>ps", function()
		builtin.grep_string({ search = vim.fn.input("Grep > ") })
	end)

	vim.api.nvim_set_keymap(
		"n",
		"<Leader>sr",
		'<CMD>lua require("telescope").extensions.git_worktree.git_worktrees()<CR>',
		{ noremap = true, silent = true }
	)

	vim.api.nvim_set_keymap(
		"n",
		"<Leader>sR",
		'<CMD>lua require("telescope").extensions.git_worktree.create_git_worktree()<CR>',
		{ noremap = true, silent = true }
	)

	vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
	keymap.set("n", "<leader>fc", function()
		require("telescope.builtin").find_files({
			cwd = "/home/dinesh/.config/nvim/",
		})
	end, { noremap = true, silent = true, desc = "Find config files" })
end

return M
