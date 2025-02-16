return {
    "hrsh7th/nvim-cmp",
    lazy = false,
    priority = 100,
    -- event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-buffer",           -- source for text in buffer
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-path",             -- source for file system paths
        "L3MON4D3/LuaSnip",             -- snippet engine
        "saadparwaiz1/cmp_luasnip",     -- for autocompletion
        "rafamadriz/friendly-snippets", -- useful snippets
        "onsails/lspkind.nvim",         -- vs-code like pictograms
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        local lspkind = require("lspkind")
        -- Add border to floating window
        -- vim.lsp.handlers["textDocument/signatureHelp"] =
        -- 	vim.lsp.with(vim.lsp.handlers.hover, { border = "single", silent = true })
        -- vim.lsp.handlers["textDocument/hover"] =
        -- 	vim.lsp.with(vim.lsp.handlers.hover, { border = "single", silend = true })

        -- Make float window transparent start

        -- local set_hl_for_floating_window = function()
        -- 	vim.api.nvim_set_hl(0, "NormalFloat", {
        -- 		link = "Normal",
        -- 	})
        -- 	vim.api.nvim_set_hl(0, "FloatBorder", {
        -- 		bg = "none",
        -- 	})
        -- end
        --
        -- set_hl_for_floating_window()

        -- vim.api.nvim_create_autocmd("ColorScheme", {
        -- 	pattern = "*",
        -- 	desc = "Avoid overwritten by loading color schemes later",
        -- 	callback = set_hl_for_floating_window,
        -- })

        -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
        require("luasnip.loaders.from_vscode").lazy_load()

        -- / cmdline setup.
        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        -- : cmdline setup.
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                {
                    name = "cmdline",
                    option = {
                        ignore_cmds = { "Man", "!" },
                    },
                },
            }),
        })

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,noselect", --preview
            },
            snippet = {                                -- configure how nvim-cmp interacts with snippet engine
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
                ["<C-e>"] = cmp.mapping.abort(),        -- close completion window
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
            }),
            -- sources for autocompletion
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" }, -- snippets
                { name = "lspkind" }, -- snippets
                { name = "buffer" },  -- text within current buffer
                { name = "path" },    -- file system paths
                -- {
                -- 	name = "cmp-dictionary",
                -- 	keyword_length = 2,
                -- 	max_item_count = 5,
                -- 	priority = 30,
                -- 	dictionary = { filepath = "/path/to/mongodb-dictionary.json", filetype = "json" },
                -- },
            }),
            -- configure lspkind for vs-code like pictograms in completion menu
            -- formatting = {
            --
            --     format = lspkind.cmp_format({
            --         maxwidth = 50,
            --         ellipsis_char = "...",
            --     }),
            -- },
        })
    end,
}
