-- Function to find or create a Todo buffer
local function get_or_create_todo_buffer()
    -- Check if a buffer named "Todo" already exists

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_name(buf) == "Todo" then
            vim.api.nvim_buf_delete(buf, { force = true })
            break
        end
    end

    print("Creating new Todo buffer")

    -- If no existing buffer is found, create a new one
    local buf = vim.api.nvim_create_buf(false, true) -- false = not listed, true = scratch
    vim.api.nvim_buf_set_name(buf, "Todo")
    vim.api.nvim_buf_set_option(buf, "modifiable", true)
    vim.api.nvim_buf_set_option(buf, "filetype", "todo")
    return buf
end

-- Function to add a task
local function add_task(buf)
    local task = vim.fn.input("Enter Task:  ")
    if task and task ~= "" then
        local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        table.insert(lines, "[ ] " .. task)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    end
end

-- Function to remove a task
local function remove_task(buf)
    local line_num = vim.api.nvim_win_get_cursor(0)[1] - 1
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    if #lines > 0 and line_num >= 0 then
        table.remove(lines, line_num + 1)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    end
end

-- Function to toggle task status
local function toggle_task(buf)
    local line_num = vim.api.nvim_win_get_cursor(0)[1] - 1
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    if line_num >= 0 and line_num < #lines then
        local line = lines[line_num + 1]
        if line:match("^%[ %]") then
            lines[line_num + 1] = line:gsub("^%[ %]", "[x]")
        elseif line:match("^%[x%]") then
            lines[line_num + 1] = line:gsub("^%[x%]", "[ ]")
        end
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    end
end

-- Function to create todo task window
local function open_todo_window()
    local buf = get_or_create_todo_buffer()

    -- Window dimensions and position
    local width = math.floor(vim.o.columns * 0.6)
    local height = math.floor(vim.o.lines * 0.6)
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    -- Floating window options
    local opts = {
        relative  = "editor",
        width     = width,
        height    = height,
        col       = col,
        row       = row,
        style     = "minimal",
        border    = "rounded",
        title     = "Todo",
        title_pos = "center"
    }

    -- Open floating window with the buffer, reusing existing window if possible
    local win = vim.api.nvim_open_win(buf, true, opts)

    -- Ensure buffer options are set (safe to call on existing buffer)
    vim.api.nvim_buf_set_option(buf, "modifiable", true)
    vim.api.nvim_buf_set_option(buf, "filetype", "todo")
    return buf, win
end

-- Function to save tasks
local function save_tasks(buf)
    vim.api.nvim_buf_call(buf, function()
        vim.cmd("w! ~/.config/nvim/todo.txt")
    end)
end

-- Function to load tasks
local function load_tasks(buf)
    if vim.fn.filereadable(vim.fn.expand("~/.config/nvim/todo.txt")) == 1 then
        local lines = vim.fn.readfile(vim.fn.expand("~/.config/nvim/todo.txt"))
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    end
end

-- Open Todo window and set keybindings
local function setup_todo()
    local buf, win = open_todo_window()
    load_tasks(buf)
    vim.api.nvim_buf_set_keymap(buf, "n", "fj", "", {
        noremap = true,
        silent = true,
        callback = function()
            save_tasks(buf)
        end
    })

    -- Buffer-local keybindings
    vim.api.nvim_buf_set_keymap(buf, "n", "a", "", {
        noremap = true,
        silent = true,
        callback = function()
            add_task(buf)
        end
    })
    vim.api.nvim_buf_set_keymap(buf, "n", "d", "", {
        noremap = true,
        silent = true,
        callback = function() remove_task(buf) end
    })
    vim.api.nvim_buf_set_keymap(buf, "n", "<leader>]", "", {
        noremap = true,
        silent = true,
        callback = function() toggle_task(buf) end
    })
    vim.api.nvim_buf_set_keymap(buf, "n", "q", "", {
        noremap = true,
        silent = true,
        callback = function()
            vim.api.nvim_win_close(win, true)
            vim.api.nvim_buf_delete(buf, { force = true })
            -- Optionally delete the buffer if you want it gone after closing
            -- vim.api.nvim_buf_delete(buf, { force = true })
        end
    })
end

-- Command to open the Todo window
vim.api.nvim_create_user_command("Todo", setup_todo, { nargs = 0 })
-- Keybinding
vim.api.nvim_set_keymap("n", "<leader>[", ":Todo<CR>", { noremap = true, silent = true })
