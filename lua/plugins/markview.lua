return {
	"OXY2DEV/markview.nvim",
	lazy = false, -- Recommended
	-- ft = "markdown" -- If you decide to lazy-load anyway
	enabled = true,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{
			"<leader>mw",
			function()
				vim.api.nvim_command(":Markview toggle")
			end,
			desc = "Toggle markdown view",
		},
	},

	opts = {
		headings = {
			enable = true,

			--- Amount of character to shift per heading level
			---@type integer
			shift_width = 1,

			heading_1 = {
				style = "label",
				shift_char = " ",
				padding_right = " ",
				sign = "󰌕 ",
				hl = "MarkviewHeading1",
			},
			heading_2 = {
				style = "label",
				hl = "MarkviewHeading2",
				shift_char = " ",
				shift_hl = "MarkviewHeading2Sign",
				padding_right = " ",
				sign = "󰌕 ",
				sign_hl = "MarkviewHeading2Sign",
				icon_hl = "MarkviewHeading2",
			},
			heading_3 = {
				style = "label",
				hl = "MarkviewHeading3",
				shift_char = " ",
				shift_hl = "MarkviewHeading3Sign",
				padding_right = " ",
				sign = "󰌕 ",
				sign_hl = "MarkviewHeading3Sign",
				icon_hl = "MarkviewHeading3",
			},
			heading_4 = {
				style = "label",
				hl = "MarkviewHeading4",
				shift_char = " ",
				shift_hl = "MarkviewHeading4Sign",
				padding_right = " ",
				sign = "󰌕 ",
				sign_hl = "MarkviewHeading4Sign",
				icon_hl = "MarkviewHeading4",
			},
			heading_5 = {
				style = "label",
				hl = "MarkviewHeading5",
				shift_char = " ",
				shift_hl = "MarkviewHeading5Sign",
				padding_right = " ",
				sign = "󰌕 ",
				sign_hl = "MarkviewHeading5Sign",
				icon_hl = "MarkviewHeading5",
			},
			heading_6 = {
				style = "label",
				hl = "MarkviewHeading6",
				shift_char = " ",
				shift_hl = "MarkviewHeading6Sign",
				padding_right = " ",
				sign = "󰌕 ",
				sign_hl = "MarkviewHeading6Sign",
				icon_hl = "MarkviewHeading6",
			},
		},
		tables = {
			enable = false,
		},
		inline_codes = {
			enable = true,
			hl = "MarkviewHeading5",
		},
	},
}
