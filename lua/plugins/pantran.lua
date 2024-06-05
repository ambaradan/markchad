return {
  -- Translator
  "potamides/pantran.nvim",
  cmd = { "Pantran" },
  keys = {
    {
      "<leader>tr",
      "<cmd>+Pantran<cr>",
      mode = { "n", "v" },
      desc = "Translate",
    },
  },
	config = function()
		require('pantran').setup({
      default_engine = "deepl",
      engines = {
        google = {
          default_target = "en",
          fallback = {
            default_target = "en",
          },
        },
        deepl = {
          auth_key = "8dee6f56-694c-a178-7839-8e4541e19463:fx",
          preserve_formatting = 1,
        },
      },
			ui = {
				height_percentage = 0.8,
				width_percentage = 0.6,
			},
			select = {
				prompt_prefix = ' ',
				selection_caret = '  ',
			},
			window = { window_config = { border = 'rounded' } },
		})
	end,
}
