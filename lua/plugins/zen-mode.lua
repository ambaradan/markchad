-- Lua
return {
	"folke/zen-mode.nvim",
	enabled = true,
	cmd = "ZenMode",
	opts = {
		window = {
			options = {
				number = false,
				relativenumber = false,
			},
		},
		kitty = {
			enabled = true,
			font = "+4", -- font size increment
		},
	},
}
