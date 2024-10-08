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
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed.
			"nvim-telescope/telescope.nvim", -- optional
			-- "ibhagwan/fzf-lua",              -- optional
			-- "echasnovski/mini.pick",         -- optional
		},
		cmd = "Neogit",
		keys = {
			{
				"<leader>ng",
				"<cmd>Neogit<cr>",
				desc = "git manager",
			},
		},
		-- 	config = function()
		-- 		dofile(vim.g.base46_cache .. "neogit")
		-- 		require("neogit").setup()
		-- 	end,
		config = true,
	},
	-- {
	-- 	"NeogitOrg/neogit",
	-- 	enabled = true,
	-- 	ft = { "diff" },
	-- 	cmd = "Neogit",
	-- 	dependencies = {
	-- 		"sindrets/diffview.nvim",
	-- 		"nvim-lua/plenary.nvim",
	-- 	},
	-- 	config = function()
	-- 		dofile(vim.g.base46_cache .. "neogit")
	-- 		require("neogit").setup()
	-- 	end,
	-- 	keys = {
	-- 		{
	-- 			"<leader>ng",
	-- 			"<cmd>Neogit<cr>",
	-- 			desc = "git manager",
	-- 		},
	-- 	},
	-- 	opts = {
	-- 		signs = { section = { "", "" }, item = { "", "" } },
	-- 		disable_commit_confirmation = true,
	-- 		integrations = { diffview = true },
	-- 		status = {
	-- 			recent_commit_count = 25,
	-- 		},
	-- 	},
	-- },
}
