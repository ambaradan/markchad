return {
  "brenoprata10/nvim-highlight-colors",
  cmd = { "HighlightColors" },
  event = { "BufRead" },
  config = true,
  keys = {
    {
      "<leader>uC",
      function()
        require("nvim-highlight-colors").toggle()
      end,
      desc = "colorizer",
    },
  },
}
