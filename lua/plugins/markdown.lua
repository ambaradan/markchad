return {
	{
		"tadmccorkle/markdown.nvim",
		enabled = true,
		ft = "markdown", -- or 'event = "VeryLazy"'
		opts = {
			on_attach = function(bufnr)
				local function toggle(key)
					return "<Esc>gv<Cmd>lua require'markdown.inline'" .. ".toggle_emphasis_visual'" .. key .. "'<CR>"
				end
				-- mapping for INSERT mode (bold, italic, inline code)
				vim.keymap.set("x", "<C-b>", toggle("b"), { buffer = bufnr })
				vim.keymap.set("x", "<C-i>", toggle("i"), { buffer = bufnr })
				vim.keymap.set("x", "<C-c>", toggle("c"), { buffer = bufnr })
        vim.keymap.set("x", "<C-s>", toggle("s"), { buffer = bufnr })
			end,
      inline_surround = {
        strikethrough = {
          text = "s",
          txt = "==",
        },
      },
		},
	},
}
