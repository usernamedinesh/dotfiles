function ColorMyPencils(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {

	{
		"rose-pine/neovim",
		config = function()
			require("rose-pine").setup({
				disable_background = true,
				styles = {
					bold = true,
					italic = false,
					transparency = true,
				},
				enable = {
					terminal = true,
					legacy_highlights = true,
					migrations = true,
				},
			})
			vim.cmd("colorscheme rose-pine")
			ColorMyPencils()
		end,
	},
}
