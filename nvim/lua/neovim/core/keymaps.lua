vim.g.mapleader = " "

--open-explorer
vim.api.nvim_set_keymap("n", "<Leader>pv", ":Oil<CR>", { noremap = true, silent = true })
--move line--
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>sv", function()
	vim.cmd([[
      update $MYVIMRC
      source $MYVIMRC
    ]])
	vim.notify("Nvim config successfully reloaded!", vim.log.levels.INFO, { title = "nvim-config" })
end, {
	silent = true,
	desc = "reload init.lua",
})

-- Move normally between wrapped lines
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Keymaps for better default experience
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

--indenting--
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
--undo--
vim.keymap.set("n", "U", "<C-r>", { noremap = true })
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")
--copy paste--
vim.api.nvim_set_keymap("v", "<S-p>", '"+y', { noremap = true })
vim.api.nvim_set_keymap("n", "<S-k>", '"+p', { noremap = true })

--format
vim.keymap.set("n", "<leader>fj", vim.lsp.buf.format)

-- Keymap for enabling Copilot
vim.api.nvim_set_keymap("n", "<leader>ce", ":Copilot enable<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>cd", ":Copilot disable<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("i", "<C-j>", "<Down>", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-k>", "<Up>", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-h>", "<Left>", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-l>", "<Right>", { noremap = true })

--command mode--
vim.api.nvim_set_keymap("n", "'", ":", { noremap = true })
vim.api.nvim_set_option("completefunc", "completefunc#omni#syntax")

--move to start and end of line
vim.api.nvim_set_keymap("n", "sk", "$", { noremap = false })
vim.api.nvim_set_keymap("n", "sj", "^", { noremap = false })

--close cureent buffer
vim.keymap.set("n", "so", "<cmd>bd<CR>", { noremap = true, silent = true, desc = "Close current buffer" })

-- Navigate buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>", { noremap = true })
vim.keymap.set("n", "<S-j>", ":bprevious<CR>", { noremap = true })
-- Select all
vim.keymap.set("n", "si", "gg<S-v>G")

--splite--
vim.keymap.set("n", "ff", ":vsplit <CR>")
vim.keymap.set("n", "sv", ":split <cr>")
vim.keymap.set("n", "sn", ":tabnew <cr>")

--resize in splite--
vim.api.nvim_set_keymap("n", "<Left>", ":vertical resize -2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Right>", ":vertical resize +2<CR>", { noremap = true, silent = true })
-- Normal mode navigation
vim.api.nvim_set_keymap("n", "<Esc>", "<cmd>noh<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "sh", "<C-w>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "sl", "<C-w>l", { noremap = true, silent = true })
vim.keymap.set("i", "jf", "<Esc>")
vim.keymap.set("v", "o", "<Esc>")
vim.keymap.set("x", "o", "<Esc>")
vim.keymap.set("x", "e", "=")

vim.api.nvim_set_keymap("n", "fj", ":w<CR>", { silent = false })
vim.api.nvim_set_keymap("n", "<leader>q", ":q!<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>wq", ":wq<CR>", { silent = true })

vim.api.nvim_set_keymap("n", "<Leader>/", ":<C-u>normal gcc<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<Leader>/", ":normal gcc<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")

vim.api.nvim_set_keymap("n", "c", "V", { silent = true })

vim.keymap.set("n", "<C-[>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-]>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

--replase with workd
vim.keymap.set("n", "<leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/<CR>", { desc = "Jump to configuration file" })
