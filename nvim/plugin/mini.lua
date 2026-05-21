vim.pack.add({
	"https://github.com/echasnovski/mini.nvim",
	"https://github.com/JoosepAlviste/nvim-ts-context-commentstring",
})

require("mini.pairs").setup()

require("mini.ai").setup({ n_lines = 500 })

require("mini.surround").setup({
	n_lines = 300,
	respect_selection_type = true,
	custom_surroundings = {
		T = {
			input = { "<(%w+)[^<>]->.-</%1>", "^<()%w+().*</()%w+()>$" },
			output = function()
				local tag_name = MiniSurround.user_input("Tag name")
				if tag_name == nil then
					return nil
				end
				return { left = tag_name, right = tag_name }
			end,
		},
	},
})

require("ts_context_commentstring").setup({ enable_autocmd = false })

require("mini.comment").setup({
	options = {
		custom_commentstring = function()
			return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
		end,
	},
})
