return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  -- disable nvim-tree
	{
		"nvim-tree/nvim-tree.lua",
		enabled = false,
		-- opts = overrides.nvimtree,
	},
  --
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "marksman",
        "markdownlint",
        "yaml-language-server",
        "bash-language-server",
        "yamllint",
        "yamlfmt",
        "shfmt",
        "vale",
      },
    },
  },
  --
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = {
  --     ensure_installed = {
  --       "vim",
  --       "lua",
  --       "vimdoc",
  --       "html",
  --       "css",
  --       "bash",
  --       "yaml",
  --       "markdown",
  --       "markdown_inline",
  --     },
  --   },
  -- },
}
