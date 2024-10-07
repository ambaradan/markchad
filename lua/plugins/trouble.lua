return {
	"folke/trouble.nvim",
	enabled = true,
	opts = {}, -- for default options, refer to the configuration section for custom setup.
	cmd = "Trouble",
	config = function()
		dofile(vim.g.base46_cache .. "trouble")
		require("trouble").setup()
	end,
	keys = {
		{
			"<leader>tt",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>tb",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
		{
			"<leader>ts",
			"<cmd>Trouble symbols toggle focus=false<cr>",
			desc = "Symbols (Trouble)",
		},
	},
}
