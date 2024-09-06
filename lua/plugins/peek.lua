return {
	"toppair/peek.nvim",
	enabled = true,
  ft = "markdown",
  	keys = {
		{
			"<leader>mp",
			"<cmd>PeekOpen<cr>",
			desc = "Markdown Preview Open",
		},
		{
			"<leader>mc",
			"<cmd>PeekClose<cr>",
			desc = "Markdown Preview Close",
		}
  },
	build = "~/.local/share/nvim/mason/bin/deno task --quiet build:fast",
	config = function()
		require("peek").setup()
		vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
		vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
	end,
}
