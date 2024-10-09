require("neogit").setup({
  kind = "auto",
  disable_builtin_notifications = true,
  integrations = {
    telescope = true,
    diffview = true,
  },
  status = {
    -- show_head_commit_hash = true,
    recent_commit_count = 20,
  },
})
