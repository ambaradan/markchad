require("neogit").setup({
	kind = "auto",
	disable_builtin_notifications = true,
	integrations = {
		telescope = true,
		diffview = true,
	},
	status = {
		-- show_head_commit_hash = true,
		recent_commit_count = 20,
	},
	commit_view = {
		kind = "floating",
		verify_commit = vim.fn.executable("gpg") == 1,
	},
})
