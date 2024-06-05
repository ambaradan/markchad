local options = {
  formatters_by_ft = {
    lua = { "stylua" },
		sh = { "shfmt" },
		bash = { "shfmt" },
		markdown = { "markdownlint" },
    yaml = { "yamlfmt" },
    css = { "prettier" },
    html = { "prettier" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

require("conform").setup(options)
