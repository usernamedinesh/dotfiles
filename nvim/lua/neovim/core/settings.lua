vim.opt.guicursor = ""
vim.g.mapleader = " "
vim.opt.nu = true
vim.opt.relativenumber = true
vim.o.clipboard = "unnamed"
vim.o.completeopt = "menuone,noselect"

vim.opt.autoindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.showmode = false

vim.opt.smartindent = true

vim.opt.wrap = false
-- vim.opt.cursorline = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
-- vim.opt.background = "dark"
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.updatetime = 50
-- vim.opt.colorcolumn = "100"
