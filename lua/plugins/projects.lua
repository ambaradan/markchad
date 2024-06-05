return {
  -- Project Manager
  {
    "coffebar/neovim-project",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      -- { "nvim-telescope/telescope.nvim", tag = "0.1.4" },
      { "Shatur/neovim-session-manager" },
    },
    keys = {
      {
        "<leader>dp",
        "<cmd>Telescope neovim-project discover theme=dropdown<cr>",
        desc = "discover projects",
      },
      {
        "<leader>hp",
        "<cmd>Telescope neovim-project history theme=dropdown<cr>",
        desc = "history projects",
      },
    },
    lazy = false,
    priority = 100,
    opts = {
      projects = { -- define project roots
        "~/lab/github/*",
        "~/lab/codeberg/*",
        "~/.config/nvim/",
        "~/.config/markchad/",
      },
    },
    init = function()
      -- enable saving the state of plugins in the session
      vim.opt.sessionoptions:append "globals" -- save global variables that start
      -- with an uppercase letter and contain at least one lowercase letter.
    end,
  },
}
