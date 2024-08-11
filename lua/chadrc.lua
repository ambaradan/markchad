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
		RenderMarkdownH1Bg = { fg = "vibrant_green", bg = "lightbg" },
		RenderMarkdownH2Bg = { fg = "yellow", bg = "lightbg" },
		RenderMarkdownH3Bg = { fg = "orange", bg = "lightbg" },
		RenderMarkdownH4Bg = { fg = "red", bg = "lightbg" },
		RenderMarkdownH5Bg = { fg = "blue", bg = "lightbg" },
		RenderMarkdownH6Bg = { fg = "teal", bg = "lightbg" },
		RenderMarkdownH1 = { fg = "vibrant_green" },
    RenderMarkdownH2 = { fg = "yellow" },
		RenderMarkdownH3 = { fg = "orange" },
    RenderMarkdownH4 = { fg = "red" },
    RenderMarkdownH5 = { fg = "blue" },
    RenderMarkdownH6 = { fg = "teal" },
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
