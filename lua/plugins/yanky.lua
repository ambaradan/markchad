return {
	-- Yanky - clipboard manager
	{
		"gbprod/yanky.nvim",
		enabled = true,
		event = "BufRead",
		dependencies = { "kkharji/sqlite.lua" },
    keys = {
      { -- Mappings for Yank Ring
        mode = { "i", "n" },
        "<A-y>",
        "<cmd>Telescope yank_history<cr>",
        desc = "Yank History (INSERT)"
      },
    },
		config = function()
			require("yanky").setup({
				highlight = {
					on_put = true,
					on_yank = true,
				},
				ring = {
					history_length = 200,
					storage = "sqlite",
					storage_path = vim.fn.stdpath("data") .. "/databases/yanky.db", -- Only for sqlite storage
					sync_with_numbered_registers = true,
					cancel_event = "update",
					ignore_registers = { "_" },
					update_register_on_cycle = false,
				},
				system_clipboard = {
					sync_with_ring = true,
				},
			})
			require("telescope").load_extension("yank_history")
		end,
	},
}
