return {
	"iamcco/markdown-preview.nvim",
	enabled = true,
	cmd = { "MarkdownPreview", "MarkdownPreviewStop" },
  ft = "markdown",
	keys = {
		{
			"<leader>mp",
			"<cmd>MarkdownPreview<cr>",
			desc = "markdown preview open",
		},
		{
			"<leader>mc",
			"<cmd>MarkdownPreviewStop<cr>",
			desc = "markdown preview close",
		},
	},
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
	init = function()
		vim.g.mkdp_theme = "dark"
		vim.g.mkdp_browser = "/usr/bin/firefox"
	end,
}
