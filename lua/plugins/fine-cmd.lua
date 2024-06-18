return {
	"VonHeikemen/fine-cmdline.nvim",
	enabled = false,
	dependencies = {
		{ "MunifTanjim/nui.nvim" },
	},
	cmd = "FineCmdline",
	keys = {
		{
			",",
			"<cmd>FineCmdline<cr>",
			desc = "cmdline",
		},
	},
	config = function()
		require("fine-cmdline").setup({
			popup = {
				position = {
					row = "80%",
					col = "50%",
				},
			},
		})
	end,
}
