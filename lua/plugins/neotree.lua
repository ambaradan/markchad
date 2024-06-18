return {
	"nvim-neo-tree/neo-tree.nvim",
	enabled = true,
	branch = "v3.x",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	keys = {
		{ -- lazy style key map
			"-",
			"<cmd>Neotree float toggle<cr>",
			desc = "file manager float",
		},
		{
			"<leader>pc",
			"<cmd>Neotree position=current<cr>",
			desc = "file manager current",
		},
		{
      "<leader>gg",
			"<cmd>Neotree float git_status<cr>",
			desc = "file manager git status",
		},
	},
	config = function()
		require("neo-tree").setup({
			popup_border_style = "rounded",
			window = {
				position = "right",
				width = 50,
			},
			icon = {
				folder_closed = "",
				folder_open = "",
				folder_empty = "ﰊ",
			},
		})
	end,
}
