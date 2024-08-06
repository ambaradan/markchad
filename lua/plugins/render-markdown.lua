return {
	"MeanderingProgrammer/render-markdown.nvim",
	enabled = true,
	latex_enabled = false,
	-- name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	ft = "markdown",
	config = function()
		require("render-markdown").setup({
			heading = {
				enabled = true,
				icons = { "☶ ", "☴ ", "☱ ", "☳ ", "☲ ", "☷ " },
				width = "block",
			},
			code = {
				enabled = true,
				-- Determines how code blocks & inline code are rendered:
				--  none: disables all rendering
				--  normal: adds highlight group to code blocks & inline code
				--  language: adds language icon to sign column and icon + name above code blocks
				--  full: normal + language
				style = "language",
				-- Highlight for code blocks & inline code
				highlight = "ColorColumn",
			},
			bullet = {
				highlight = "Boolean",
			},
		})
	end,
}
