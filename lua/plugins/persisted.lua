return {
	"olimorris/persisted.nvim",
	enabled = true,
	keys = {
		{
			"<leader>sl",
			function()
				require("persisted").load()
			end,
			desc = "Load Session",
		},
		{
			"<A-l>",
			function()
				require("persisted").load({ last = true })
			end,
			desc = "Load Last Session",
		},
		{
			"<leader>st",
			function()
				require("persisted").stop()
			end,
			desc = "Stop Current Session",
		},
		{
			"<leader>ss",
			function()
				require("persisted").save()
			end,
			desc = "Save Current Session",
		},
		{
			"<leader>sS",
			function()
				require("persisted").select()
			end,
			desc = "Select Sessions",
		},
		{
			"<A-s>",
			"<cmd>Telescope persisted<cr>",
			desc = "Select Session (Telescope)",
		},
	},
	config = function()
		vim.o.sessionoptions = "buffers,curdir,folds,globals,tabpages,winpos,winsize"

		require("persisted").setup({
			autoload = true,
		})

		require("telescope").load_extension("persisted")
	end,
	dependencies = { "nvim-telescope/telescope.nvim" },
}
