-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "onedark",
	hl_override = {
		FloatBorder = { fg = "light_grey", bg = "black" },
		["@markup.italic"] = { fg = "nord_blue" },
		["@markup.strong"] = { fg = "cyan" },
	},
	hl_add = {
		NeoTreeDirectoryIcon = { fg = "yellow" },
		NeoTreeDirectoryName = { fg = "sun" },
		NeoTreeFileName = { fg = "green" },
		NeoTreeFloatBorder = { fg = "one_bg2", bg = "black" },
		NeoTreeFloatTitle = { fg = "yellow", bg = "black" },
    titleH1 = { fg = "vibrant_green" },
    titleH2 = { fg = "yellow"},
    titleH3 = { fg = "orange" },
    titleH4 = { fg = "red" },
    titleH5 = { fg = "blue" },
    titleH6 = { fg = "teal" },
	},
}
M.ui = {
	cmp = {
		icons = true,
		lspkind_text = true,
		style = "flat_dark", -- default/flat_light/flat_dark/atom/atom_colored
	},
}

return M
