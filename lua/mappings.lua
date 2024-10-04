require("nvchad.mappings")

local map = vim.keymap.set

map("n", ":", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- replacement of standard nvimtree mapping with neotree
map("n", "<C-n>", "<cmd>Neotree right toggle<CR>", { desc = "neotree toggle window" })
map("n", "<leader>e", "<cmd>Neotree focus<CR>", { desc = "neotree focus window" })
-- Custom floating term
map({ "n", "t" }, "<A-i>", function()
	require("nvchad.term").toggle({
		pos = "float",
		id = "floatTerm",
		float_opts = {
			row = 0.45,
			col = 0.40,
			width = 0.6,
			height = 0.4,
		},
	})
end, { desc = "terminal toggle floating term" })

-- Command to close all buffers
map("n", "<leader>cx", "<cmd>:%bd!<cr>", { desc = "Close all buffers" })

-- Toggle Cmp
map("n", "<leader>nc", function()
	vim.b.x = not vim.b.x
	require("cmp").setup.buffer({ enabled = not vim.b.x })
end, { desc = "Toggle Cmp Support" })

-- Keyboard users
vim.keymap.set("n", "<C-t>", function()
	require("menu").open("default")
end, {})
-- New Menu UI
-- mouse users + nvimtree users!
vim.keymap.set("n", "<RightMouse>", function()
	vim.cmd.exec('"normal! \\<RightMouse>"')

	local options = vim.bo.ft == "markdown" and "markchad" or "default"
	require("menu").open(options, { mouse = true })
end, {})
