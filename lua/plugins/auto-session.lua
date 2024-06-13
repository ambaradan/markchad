return {
	{
		"rmagatti/auto-session",
		enabled = true,
		lazy = false,
		keys = {
			{ "<leader>qr", "<cmd>SessionRestore<CR>", desc = "Restore Session" },
			{ "<leader>qs", "<cmd>SessionSave<CR>", desc = "Save Session" },
			{ "<leader>qd", "<cmd>SessionDelete<CR>", desc = "Delete this Session" },
			{ "<leader>qf", "<cmd>Telescope session-lens search_session<CR>", desc = "Find sessions" },
		},
		config = function()
			local auto_session = require("auto-session")

			auto_session.setup({
				auto_restore_enabled = true,
				auto_session_suppress_dirs = { "~/Downloads", "~/Documents", "~/Desktop", "~/" },
				auto_save_enabled = true,
				auto_session_use_git_branch = true,
			})
		end,
	},
}
