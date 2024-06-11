require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

map("n", ":", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Aligns the table cells to the width
map("v", "<leader>ta", "!pandoc -t markdown-simple_tables<cr>", { silent = true, desc = "Align md table" })
-- Command to close all buffers
map("n", "<leader>cx", function()
	require("nvchad.tabufline").closeAllBufs()
end, { desc = "Close All Buffers" })
-- Toggle Cmp
map("n", "<leader>nc", function()
	vim.b.x = not vim.b.x
	require("cmp").setup.buffer({ enabled = not vim.b.x })
end, { desc = "Toggle Cmp Support" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
