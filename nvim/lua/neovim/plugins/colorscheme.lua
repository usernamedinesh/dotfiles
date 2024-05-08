function ColorMyPencils(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end
--
return {

	{
		"rose-pine/neovim",
		name = "rose-pine",
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
			vim.cmd("colorscheme rose-pine-main")
			-- ColorMyPencils()
		end,
	},
	{
		"askfiy/visual_studio_code",
		priority = 100,
		config = function()
			require("visual_studio_code").setup({
				mode = "dark",
				preset = true,
				transparent = true,
			})
		end,
	},
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "sainnhe/gruvbox-material" },
}
