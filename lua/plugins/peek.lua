return {
	"toppair/peek.nvim",
	enabled = true,
	ft = "markdown",
	keys = {
		{
			mode = { "n", "i" },
			"<A-o>",
			"<cmd>PeekOpen<cr>",
			desc = "Open Markdown Preview",
		},
		{
			mode = { "n", "i" },
			"<A-c>",
			"<cmd>PeekClose<cr>",
			desc = "Close Markdown Preview",
		},
	},
	build = "~/.local/share/nvim/mason/bin/deno task --quiet build:fast",
	config = function()
		require("peek").setup()
		vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
		vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
	end,
}
