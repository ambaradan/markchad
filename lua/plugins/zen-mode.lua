return {
	"Manas140/Zazen.nvim",
	enabled = true,
	cmd = "Zazen",
	keys = {
		{
			"<leader>zm",
			"<cmd>Zazen<cr>",
			desc = "Zen Mode",
		},
	},
	config = function()
		require("zazen").setup({
			num = false, -- show numbers
			gap = 0.2, -- prefered to keep value under 0.5
			border = "none",
		})
	end,
}
