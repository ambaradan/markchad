-- Lua
return {
	"folke/zen-mode.nvim",
	enabled = true,
	cmd = "ZenMode",
	keys = {
		{ "<leader>zm", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
	},
	opts = {
		window = {
			options = {
				number = false,
				relativenumber = false,
			},
		},
		plugins = {
			kitty = {
				enabled = true,
				font = "+2", -- font size increment
			},
		},
	},
}
