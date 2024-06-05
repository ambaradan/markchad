return {
  -- Suggested dependencies
  {
    "BurntSushi/ripgrep",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    event = { "FileType TelescopePrompt" },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "tsakirist/telescope-lazy.nvim",
    },
    require("telescope").setup {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = {
          prompt_position = "bottom",
          horizontal = {
            height = 0.85,
          },
        },
      },
      pickers = {
        buffers = { sort_lastused = true, sort_mru = true, previewer = false, hidden = true, theme = "dropdown" },
        command_history = { theme = "dropdown" },
        git_status = { theme = "ivy" },
        git_commits = { theme = "ivy" },
        oldfiles = { previewer = false, theme = "ivy" },
      },
    },
  },
  -- Navigate Markdown Heading
  {
    "crispgm/telescope-heading.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>nh",
        "<cmd>Telescope heading theme=dropdown<cr>",
        desc = "Navigate Heading",
      },
    },
    config = function()
      require("telescope").load_extension "heading"
    end,
  },
}
