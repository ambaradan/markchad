-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(
---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "gruvchad",
	hl_override = {
		FloatBorder = { fg = "light_grey", bg = "black" },
		["@markup.italic"] = { fg = "nord_blue" },
		["@markup.strong"] = { fg = "cyan" },
	},
	hl_add = {
		NeoTreeBufferNumber = { fg = "folder_bg" }, --The buffer number shown in the buffers source.
		NeoTreeCursorLine = { fg = "teal" }, --|hl-CursorLine| override in Neo-tree window.
		NeoTreeDimText = { fg = "light_grey" }, --Greyed out text used in various places.
		NeoTreeDirectoryIcon = { fg = "vibrant_green" }, -- Directory icon
		NeoTreeDirectoryName = { fg = "blue" }, --Directory name
		NeoTreeDotfile = { fg = "green" }, --Used for icons and names when dotfiles are filtered.
		NeoTreeFileIcon = { fg = "nord_blue" }, --File icon, when not overridden by devicons.
		NeoTreeFileName = { fg = "sun" }, --File name, when not overwritten by another status.
		NeoTreeFileNameOpened = { fg = "blue" }, --File name when the file is open. Not used yet.
		NeoTreeFilterTerm = { }, --The filter term, as displayed in the root node.
		NeoTreeFloatBorder = { fg = "one_bg2", bg = "black" }, --The border for pop-up windows.
		NeoTreeFloatTitle = { fg = "yellow", bg = "black" }, --Used for the title text of pop-ups when the border-style is set to another style than "NC". This is derived from NeoTreeFloatBorder.
		NeoTreeGitAdded = {  }, --File name when the git status is added.
		NeoTreeGitConflict = {  }, --File name when the git status is conflict.
		NeoTreeGitDeleted = {  }, --File name when the git status is deleted.
		NeoTreeGitIgnored = {  }, --File name when the git status is ignored.
		NeoTreeGitModified = { fg = "red" }, --File name when the git status is modified.
		NeoTreeGitUnstaged = { fg = "orange" }, --Used for git unstaged symbol.
		NeoTreeGitUntracked = {  }, --File name when the git status is untracked.
		NeoTreeGitStaged = {  }, --Used for git staged symbol.
		NeoTreeHiddenByName = {  }, --Used for icons and names when `hide_by_name` is used.
		NeoTreeIndentMarker = {  }, --The style of indentation markers (guides). By default, the "Normal" highlight is used.
		NeoTreeExpander = {  }, --Used for collapsed/expanded icons.
		NeoTreeNormal = {  }, --|hl-Normal| override in Neo-tree window.
		NeoTreeNormalNC = {  }, --|hl-NormalNC| override in Neo-tree window.
		NeoTreeSignColumn = {  }, --|hl-SignColumn| override in Neo-tree window.
		NeoTreeStats = {  }, --Used for "stat" columns like size, last modified, etc.
		NeoTreeStatsHeader = {  }, --Used for the header (top line) of the above columns.
		NeoTreeStatusLine = {  }, --|hl-StatusLine| override in Neo-tree window.
		NeoTreeStatusLineNC = {  }, --|hl-StatusLineNC| override in Neo-tree window.
		NeoTreeVertSplit = {  }, --|hl-VertSplit| override in Neo-tree window.
		NeoTreeWinSeparator = {  }, --|hl-WinSeparator| override in Neo-tree window.
		NeoTreeEndOfBuffer = {  }, --|hl-EndOfBuffer| override in Neo-tree window.
		NeoTreeRootName = { fg = "vibrant_green" }, --The name of the root node.
		NeoTreeSymbolicLinkTarget = {  }, --Symbolic link target.
		NeoTreeTitleBar = {  }, --Used for the title bar of pop-ups, when the border-style is set to "NC". This is derived from NeoTreeFloatBorder.
		NeoTreeWindowsHidden = {  }, --Used for icons and names that are hidden on Windows.

		-- NeoTreeDirectoryIcon = { fg = "yellow" },
		-- NeoTreeDirectoryName = { fg = "sun" },
		-- NeoTreeFileName = { fg = "green" },
		-- NeoTreeFloatBorder = { fg = "one_bg2", bg = "black" },
		-- NeoTreeFloatTitle = { fg = "yellow", bg = "black" },
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
		RenderMarkdownTableHead = { fg = "light_grey" },
		RenderMarkdownTableRow = { fg = "light_grey" },
		RenderMarkdownTableFill = { fg = "light_grey" },
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
