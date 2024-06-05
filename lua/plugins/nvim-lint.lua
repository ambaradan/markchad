return {
  -- Linter
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require("lint").linters_by_ft = {
        markdown = { "markdownlint", "vale" },
        yaml = { "yamllint" },
        bash = { "shellcheck" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
}
