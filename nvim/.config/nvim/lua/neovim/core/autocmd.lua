-- working
vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function()
        vim.keymap.set("n", "<CR>", "<cr><C-w><C-p>", { buffer = true })
    end
})


-- Enable screen key
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.cmd("Screenkey")
    end,
})
-- vim.api.nvim_create_autocmd("BufReadPost", {
--     pattern = "*.js,*.ts",
--     callback = function()
--         -- Any logic here may cause interference, so remove it temporarily
--     end,
-- })
-- Keep the cursor position when yanking
local cursorPreYank

vim.keymap.set({ "n", "x" }, "y", function()
    cursorPreYank = vim.api.nvim_win_get_cursor(0)
    return "y"
end, { expr = true })

vim.keymap.set("n", "Y", function()
    cursorPreYank = vim.api.nvim_win_get_cursor(0)
    return "y$"
end, { expr = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        if vim.v.event.operator == "y" and cursorPreYank then
            vim.api.nvim_win_set_cursor(0, cursorPreYank)
        end
    end,
})

-- When i open any help it directly open in right split helpful
local api = vim.api
local autocmd = api.nvim_create_autocmd
local cmd = vim.cmd
local bo = vim.bo
local opt_local = vim.opt_local

autocmd("FileType", {
    desc = "Automatically Split help Buffers to the right",
    pattern = "help",
    command = "wincmd L",
})

-- cursorline
autocmd({ "UIEnter", "ColorScheme" }, {
    desc =
    "Corrects terminal background color according to colorscheme, see: https://www.reddit.com/r/neovim/comments/1ehidxy/you_can_remove_padding_around_neovim_instance/",
    callback = function()
        if api.nvim_get_hl(0, { name = "Normal" }).bg then
            io.write(string.format("\027]11;#%06x\027\\", api.nvim_get_hl(0, { name = "Normal" }).bg))
        end
        autocmd("UILeave", {
            callback = function()
                io.write("\027]111\027\\")
            end,
        })
    end,
})


-- Create or retrieve an autocommand group named "TerminalLocalOptions"
local terminal = api.nvim_create_augroup("TerminalLocalOptions", { clear = true })

-- Terminal-specific settings for "TermOpen" event
api.nvim_create_autocmd("TermOpen", {
    group = terminal,
    pattern = "*",
    callback = function(event)
        -- Disable cursorline for better terminal visibility
        opt_local.cursorline = false
        -- Hide line numbers in terminal buffers
        vim.api.nvim_buf_set_option(event.buf, "number", false) -- Disable absolute line numbers
        vim.api.nvim_buf_set_option(event.buf, "relativenumber", false)

        -- Escape sequence for exiting terminal mode
        local code_term_esc = api.nvim_replace_termcodes("<C-\\<C-n>", true, true, true)

        -- Map <Ctrl-h/j/k/l> for navigating splits from terminal mode
        for _, key in ipairs({ "h", "j", "k", "l" }) do
            vim.keymap.set("t", "<C-" .. key .. ">", function()
                local code_dir = api.nvim_replace_termcodes("<C-" .. key .. ">", true, true, true)
                api.nvim_feedkeys(code_term_esc .. code_dir, "t", true)
            end, { noremap = true, silent = true })
        end

        -- Set filetype to "terminal" if not already set
        if bo.filetype == "" then
            api.nvim_set_option_value("filetype", "terminal", { buf = event.buf })
        end

        -- Automatically start in insert mode if enabled
        if vim.g.catgoose_terminal_enable_startinsert == 1 then
            cmd("startinsert")
        end
    end,
})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Automatically enter insert mode when re-entering a terminal window
api.nvim_create_autocmd("WinEnter", {
    group = terminal,
    pattern = "*",
    callback = function()
        if bo.filetype == "terminal" and vim.g.catgoose_terminal_enable_startinsert then
            cmd("startinsert")
        end
    end,
})

-- add all buffers filenames at the bottom of the file at statusbar or statusline whatever
-- I know there is better ways to do it this works for me !
vim.o.statusline = "%!v:lua.ShowBuffers()"

function ShowBuffers()
    local current_buf = vim.fn.bufnr('%')                   -- Get f the current buffer number
    local buffers = vim.fn.getbufinfo({ buflisted = true }) -- Get all listed buffers
    local buffer_list = {}

    for _, buf in ipairs(buffers) do
        local buf_name = vim.fn.fnamemodify(buf.name, ":t") -- Get the file name
        if buf.bufnr == current_buf then
            -- ADD symbold and color in current buffer name
            table.insert(buffer_list, "%#CurrentBuffer#<" .. buf_name .. ">%>")
        else
            table.insert(buffer_list, buf_name)
        end
    end

    return table.concat(buffer_list, " | ") --Split
end

vim.api.nvim_set_hl(0, "CurrentBuffer", { fg = "#FFFFFF", bg = "#000000", italic = true })

--ADD color to the bottom line
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        vim.api.nvim_set_hl(0, "StatusLine", { bg = "#000000", fg = "#FFFFFF" })
        vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#000000", fg = "#808080" })
    end
})

-- show cursor line only in active window
local cursorGrp = vim.api.nvim_create_augroup("CursorLine", { clear = true })
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
    pattern = "*",
    command = "set cursorline",
    group = cursorGrp,
})
vim.api.nvim_create_autocmd(
    { "InsertEnter", "WinLeave" },
    { pattern = "*", command = "set nocursorline", group = cursorGrp }
)
--Restore cursor to file position in prevous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            vim.cmd('normal! g`"zz')
        end
    end,
})
