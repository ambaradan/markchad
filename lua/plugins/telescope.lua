return {
	-- Suggested dependencies
	{
		"BurntSushi/ripgrep",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		event = { "FileType TelescopePrompt" },
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"tsakirist/telescope-lazy.nvim",
		},
    keys = {
      {
        "<A-g>",
        "<cmd>Telescope live_grep<cr>",
        desc = "Live Grep"
      },
    },
		require("telescope").setup({
			defaults = {
				layout_strategy = "horizontal",
				layout_config = {
					prompt_position = "bottom",
					horizontal = {
						height = 0.85,
					},
				},
			},
			pickers = {
				buffers = {
					sort_lastused = true,
					sort_mru = true,
					previewer = false,
					hidden = true,
					theme = "dropdown",
				},
				command_history = { theme = "dropdown" },
				git_status = { theme = "ivy" },
				git_commits = { theme = "ivy" },
				oldfiles = { previewer = false, theme = "ivy" },
			},
		}),
	},
  -- Alternative Command Line
	{
		"jonarrien/telescope-cmdline.nvim",
		enabled = true,
		keys = {
			{ ",", "<cmd>Telescope cmdline<cr>", desc = "Cmdline" },
		},
		config = function()
			require("telescope").load_extension("cmdline")
		end,
	},
}
