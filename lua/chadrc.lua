-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(
---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "catppuccin",
	integrations = { "neogit", "markview" },
	hl_override = {
		FloatBorder = { fg = "light_grey", bg = "black" },
		["@markup.italic"] = { fg = "nord_blue" },
		["@markup.strong"] = { fg = "cyan" },
	},
	hl_add = {
		NeoTreeBufferNumber = { fg = "baby_pink" }, --The buffer number shown in the buffers source.
		NeoTreeCursorLine = { fg = "vibrant_green" }, --|hl-CursorLine| override in Neo-tree window.
		NeoTreeDimText = { fg = "light_grey" }, --Greyed out text used in various places.
		NeoTreeDirectoryIcon = { fg = "folder_bg" }, -- Directory icon
		NeoTreeDirectoryName = { fg = "folder_bg" }, --Directory name
		NeoTreeDotfile = { fg = "green" }, --Used for icons and names when dotfiles are filtered.
		NeoTreeFileIcon = { fg = "baby_pink" }, --File icon, when not overridden by devicons.
		NeoTreeFileName = { fg = "white" }, --File name, when not overwritten by another status.
		NeoTreeFileNameOpened = { fg = "blue" }, --File name when the file is open. Not used yet.
		NeoTreeFilterTerm = { fg = "green" }, --The filter term, as displayed in the root node.
		NeoTreeFloatBorder = { fg = "one_bg2", bg = "black" }, --The border for pop-up windows.
		NeoTreeFloatTitle = { fg = "nord_blue", bg = "black" }, --Used for the title text of pop-ups when the border-style is set to another style than "NC". This is derived from NeoTreeFloatBorder.
		NeoTreeGitAdded = { fg = "blue" }, --File name when the git status is added.
		NeoTreeGitConflict = { fg = "red" }, --File name when the git status is conflict.
		NeoTreeGitDeleted = { fg = "red" }, --File name when the git status is deleted.
		NeoTreeGitIgnored = { fg = "light_grey" }, --File name when the git status is ignored.
		NeoTreeGitModified = { fg = "orange" }, --File name when the git status is modified.
		NeoTreeGitUnstaged = { fg = "red" }, --Used for git unstaged symbol.
		NeoTreeGitUntracked = { fg = "purple" }, --File name when the git status is untracked.
		NeoTreeGitStaged = { fg = "blue" }, --Used for git staged symbol.
		NeoTreeHiddenByName = { fg = "light_grey" }, --Used for icons and names when `hide_by_name` is used.
		NeoTreeIndentMarker = { fg = "light_grey" }, --The style of indentation markers (guides). By default, the "Normal" highlight is used.
		NeoTreeExpander = { fg = "orange" }, --Used for collapsed/expanded icons.
		NeoTreeNormal = {}, --|hl-Normal| override in Neo-tree window.
		NeoTreeNormalNC = {}, --|hl-NormalNC| override in Neo-tree window.
		NeoTreeSignColumn = {}, --|hl-SignColumn| override in Neo-tree window.
		NeoTreeStats = {}, --Used for "stat" columns like size, last modified, etc.
		NeoTreeStatsHeader = {}, --Used for the header (top line) of the above columns.
		NeoTreeStatusLine = {}, --|hl-StatusLine| override in Neo-tree window.
		NeoTreeStatusLineNC = {}, --|hl-StatusLineNC| override in Neo-tree window.
		NeoTreeVertSplit = {}, --|hl-VertSplit| override in Neo-tree window.
		NeoTreeWinSeparator = {}, --|hl-WinSeparator| override in Neo-tree window.
		NeoTreeEndOfBuffer = {}, --|hl-EndOfBuffer| override in Neo-tree window.
		NeoTreeRootName = { fg = "sun" }, --The name of the root node.
		NeoTreeSymbolicLinkTarget = { fg = "cyan" }, --Symbolic link target.
		NeoTreeTitleBar = { fg = "orange" }, --Used for the title bar of pop-ups, when the border-style is set to "NC". This is derived from NeoTreeFloatBorder.
		NeoTreeWindowsHidden = {}, --Used for icons and names that are hidden on Windows.

		-- NeoTreeDirectoryIcon = { fg = "yellow" },
		-- NeoTreeDirectoryName = { fg = "sun" },
		-- NeoTreeFileName = { fg = "green" },
		-- NeoTreeFloatBorder = { fg = "one_bg2", bg = "black" },
		-- NeoTreeFloatTitle = { fg = "yellow", bg = "black" },
		MarkviewHeading1 = { fg = "vibrant_green", bg = "lightbg" },
		MarkviewHeading1Sign = { fg = "vibrant_green" },
		MarkviewHeading2 = { fg = "yellow", bg = "lightbg" },
		MarkviewHeading2Sign = { fg = "yellow" },
		MarkviewHeading3 = { fg = "orange", bg = "lightbg" },
		MarkviewHeading3Sign = { fg = "orange" },
		MarkviewHeading4 = { fg = "red", bg = "lightbg" },
		MarkviewHeading4Sign = { fg = "red" },
		MarkviewHeading5 = { fg = "blue", bg = "lightbg" },
		MarkviewHeading5Sign = { fg = "blue" },
		MarkviewHeading6 = { fg = "teal", bg = "lightbg" },
		MarkviewHeading6Sign = { fg = "teal" },
		MarkviewCode = { bg = "black" },
		MarkviewListItemMinus = { fg = "blue" },
		MarkviewListItemPlus = { fg = "teal" },
		MarkviewListItemStar = { fg = "yellow" },
	},
}

M.ui = {
	cmp = {
		style = "flat_dark",
	},
	statusline = {
		theme = "vscode_colored",
	},
}

return M
