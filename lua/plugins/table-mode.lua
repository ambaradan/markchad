return {
	enabled = true,
	ft = "markdown",
	"Kicamon/markdown-table-mode.nvim",
	config = function()
		require("markdown-table-mode").setup()
	end,
}
