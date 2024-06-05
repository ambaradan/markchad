return {
  {
    "rmagatti/auto-session",
    lazy = false,
    keys = {
      { "<leader>qr", "<cmd>SessionRestore<CR>", desc = "Restore Session" },
      { "<leader>qs", "<cmd>SessionSave<CR>", desc = "Save Session" },
      { "<leader>qd", "<cmd>SessionDelete<CR>", desc = "Delete this Session" },
      { "<leader>qf", "<cmd>Telescope session-lens search_session<CR>", desc = "Find sessions" },
    },
    opts = {
      log_level = vim.log.levels.ERROR,
      auto_session_enabled = true,
      auto_save_enabled = true,
      auto_restore_enabled = true,
      auto_session_suppress_dirs = { "~/", "/", "~/Downloads", "~/Documents", "~/dev" },
      auto_session_use_git_branch = true,
      -- auto_session_enable_last_session = false,
    },
  },
}
