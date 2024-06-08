return {
	"MeanderingProgrammer/markdown.nvim",
	enabled = true,
	latex_enabled = false,
	name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	ft = "markdown",
	config = function()
		require("render-markdown").setup({
			-- Characters that will replace the # at the start of headings
			headings = { "☶ ", "☴ ", "☱ ", "☳ ", "☲ ", "☷ " },
			table_style = "none",
			highlights = {
				heading = {
					-- Background of heading line
					backgrounds = { "CmpItemKindType", "CmpItemKindText", "CmpItemKindConstant", "CmpItemKindValue", "CmpItemKindUnit", "CmpItemKindFolder" },
					-- Foreground of heading character only
					foregrounds = {
						"markdownH1",
						"markdownH2",
						"markdownH3",
						"markdownH4",
						"markdownH5",
						"markdownH6",
					},
				},
				bullet = "@markup.list",
			},
		})
	end,
}
