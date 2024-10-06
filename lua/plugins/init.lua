return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  -- disable nvim-tree
	{
		"nvim-tree/nvim-tree.lua",
		enabled = false,
		-- opts = overrides.nvimtree,
	},
  {
    "ambaradan/menu",
    lazy = "false",
    branch = "markchad_menu",
  },
  --
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "bash",
        "yaml",
        "markdown",
        "markdown_inline",
      },
    },
  },
}
