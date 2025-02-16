function ColorMyPencils(color)
    color = color or "rose-pine-moon"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {

    {
        "vague2k/vague.nvim",
        config = function()
            require("vague").setup({
                transparent = true,
                style = {
                    -- "none" is the same thing as default. But "italic" and "bold" are also valid options
                    boolean = "none",
                    number = "none",
                    float = "bold",
                    error = "bold",
                    comments = "italic",
                    conditionals = "bold",
                    functions = "bold",
                    headings = "bold",
                    operators = "bold",
                    strings = "bold",
                    variables = "bold",

                    -- keywords
                    keywords = "italic",
                    keyword_return = "italic",
                    keywords_loop = "italic",
                    keywords_label = "italic",
                    keywords_exception = "italic",

                    -- builtin
                    builtin_constants = "none",
                    builtin_functions = "none",
                    builtin_types = "none",
                    builtin_variables = "none",
                },
            })
            -- vim.cmd.colorscheme("vague")
        end
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require('rose-pine').setup({
                disable_background = true,
                dim_inactive_windows = false,
                extend_background_behind_borders = true,
                styles = {
                    italic = false,
                    transparency = true,
                },
            })

            ColorMyPencils();
        end
    },

}
