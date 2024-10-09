return {
	-- diffview require for Neogit
	{
		"lewis6991/gitsigns.nvim",
		dependencies = {
			{
				"sindrets/diffview.nvim",
				config = true,
			},
		},
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration
			"nvim-telescope/telescope.nvim", -- optional
		},
		cmd = "Neogit",
		keys = {
			{
				"<leader>ng",
				"<cmd>Neogit kind=vsplit<cr>",
				desc = "git manager workspace",
			},
			{
				"<leader>nf",
				"<cmd>Neogit cwd=%:p:h kind=vsplit<cr>",
				desc = "git manager current file",
			},
		},
		config = function()
			require("configs.neogit")
		end,
	},
}
