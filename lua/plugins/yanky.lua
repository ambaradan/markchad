return {
  -- Yanky - clipboard manager
  {
    "gbprod/yanky.nvim",
    event = "BufRead",
    dependencies = { "kkharji/sqlite.lua" },
    config = function()
      require("yanky").setup {
        highlight = {
          on_put = true,
          on_yank = true,
        },
        ring = {
          history_length = 100,
          storage = "sqlite",
          storage_path = vim.fn.stdpath "data" .. "/databases/yanky.db", -- Only for sqlite storage
          sync_with_numbered_registers = true,
          cancel_event = "update",
          ignore_registers = { "_" },
          update_register_on_cycle = false,
        },
        system_clipboard = {
          sync_with_ring = true,
        },
      }
      require("telescope").load_extension "yank_history"
      -- Mappings for Yank Ring
      vim.keymap.set("n", "<leader>y", "<CMD> Telescope yank_history<CR>", { desc = "Yank History" })
      vim.keymap.set("i", "<c-y>", "<CMD> Telescope yank_history<CR>", { desc = "Yank History" })
    end,
  },
}
