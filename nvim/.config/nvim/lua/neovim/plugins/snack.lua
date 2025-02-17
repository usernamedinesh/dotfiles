return {
    {
        "folke/snacks.nvim",
        opts = {
            image = {
                enabled = true,
                doc = {
                    inline = vim.g.neovim_mode == "skitty" and true or false,
                    float = true,
                    max_width = vim.g.neovim_mode == "skitty" and 20 or 60,
                    max_height = vim.g.neovim_mode == "skitty" and 10 or 30,
                }
            },
            bigfile = { enabled = true },
            picker = {
                matcher = {
                    frecency = true,
                },
            },
            notifier = {
                enabled = false,
                top_down = false, -- place notifications from top to bottom
            },
        },

        keys = {

            {
                "<leader>fi",
                function()
                    Snacks.picker.files({
                        on_show = function()
                            vim.cmd.stopinsert()
                        end,
                        cwd = "/home/dinesh/.config/i3"
                    })
                end,
                desc = "Find Config File (i3)"
            },
            { "<leader>,",  function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
            { "<leader>/",  function() Snacks.picker.grep() end,                                    desc = "Grep" },
            { "<leader>:",  function() Snacks.picker.command_history() end,                         desc = "Command History" },
            { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
            { "<leader>fg", function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
            { "<leader>fr", function() Snacks.picker.recent() end,                                  desc = "Recent" },

            { "<leader>gb", function() Snacks.picker.git_branches({ layout = "select" }) end,       desc = "Git Branches" },
            { "<leader>gl", function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
            { "<leader>gs", function() Snacks.picker.git_status() end,                              desc = "Git Status" },
            -- { "<leader>gS", function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
            -- { "<leader>gd", function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
            { "<leader>gf", function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },

            { "<leader>sb", function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
            -- { "<leader>sB", function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
            { "<leader>sw", function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word", mode = { "n", "x" } },

            -- search
            { '<leader>s"', function() Snacks.picker.registers() end,                               desc = "Registers" },
            { '<leader>s/', function() Snacks.picker.search_history() end,                          desc = "Search History" },
            { "<leader>sa", function() Snacks.picker.autocmds() end,                                desc = "Autocmds" },
            { "<leader>sb", function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
            { "<leader>sc", function() Snacks.picker.command_history() end,                         desc = "Command History" },
            { "<leader>sC", function() Snacks.picker.commands() end,                                desc = "Commands" },
            { "<leader>sh", function() Snacks.picker.help() end,                                    desc = "Help Pages" },
            { "<leader>sH", function() Snacks.picker.highlights() end,                              desc = "Highlights" },
            { "<leader>si", function() Snacks.picker.icons() end,                                   desc = "Icons" },
            { "<leader>sj", function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
            { "<leader>sk", function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
            { "<leader>su", function() Snacks.picker.undo() end,                                    desc = "Undo History" },
            { "<leader>uC", function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },

            -- LSP
            { "gd",         function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
            { "gD",         function() Snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
            { "gr",         function() Snacks.picker.lsp_references() end,                          nowait = true,                     desc = "References" },
            { "gI",         function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
            { "gy",         function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
            { "<leader>ss", function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
            { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },

            -- Other
            { "<leader>.",  function() Snacks.scratch() end,                                        desc = "Toggle Scratch Buffer" },
            { "<leader>S",  function() Snacks.scratch.select() end,                                 desc = "Select Scratch Buffer" },
            { "<leader>cR", function() Snacks.rename.rename_file() end,                             desc = "Rename File" },
            { "<leader>gB", function() Snacks.gitbrowse() end,                                      desc = "Git Browse",               mode = { "n", "v" } },
            {
                "<leader>gl",
                function()
                    Snacks.picker.git_log({
                        finder = "git_log",
                        format = "git_log",
                        preview = "git_show",
                        confirm = "git_checkout",
                        -- layout = "vertical",
                    })
                end,
                desc = "Git Log",
            },
            {
                "<leader>km",
                function()
                    Snacks.picker.keymaps({
                        layout = "vertical",
                    })
                end,
                desc = "Keymaps",
            },
            -- File picker
            {
                "<leader>ff",
                function()
                    Snacks.picker.files({
                        finder = "files",
                        format = "file",
                        show_empty = true,
                        supports_live = true,
                        -- layout = "vscode"
                    })
                end,
                desc = "Find Files",
            },
            -- Navigate my buffers
            {
                "<leader>fb",
                function()
                    Snacks.picker.buffers({
                        -- I always want my buffers picker to start in normal mode
                        on_show = function()
                            vim.cmd.stopinsert()
                        end,
                        finder = "buffers",
                        format = "buffer",
                        hidden = false,
                        unloaded = true,
                        current = true,
                        layout = "vscode",
                        sort_lastused = true,
                        win = {
                            input = {
                                keys = {
                                    ["d"] = "bufdelete",
                                },
                            },
                            list = { keys = { ["d"] = "bufdelete" } },
                        },
                        -- In case you want to override the layout for this keymap
                    })
                end,
                desc = "[P]Snacks picker buffers",
            },
        },
    },
}
