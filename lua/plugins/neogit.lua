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
	-- Git Manager
	{
		"NeogitOrg/neogit",
		enabled = true,
		ft = { "diff" },
		cmd = "Neogit",
		dependencies = {
			"sindrets/diffview.nvim",
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{
				"<leader>ng",
				"<cmd>Neogit<cr>",
				desc = "git manager",
			},
		},
		opts = {
			signs = { section = { "", "" }, item = { "", "" } },
			disable_commit_confirmation = true,
			integrations = { diffview = true },
			status = {
				recent_commit_count = 25,
			},
		},
	},
}
