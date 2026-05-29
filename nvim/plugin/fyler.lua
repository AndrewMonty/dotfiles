vim.pack.add({
	"https://github.com/nvim-mini/mini.icons",
	"https://github.com/A7Lavinraj/fyler.nvim",
})

require("fyler").setup({
	integrations = {
		icon = "nvim_web_devicons",
	},
	views = {
		finder = {
			close_on_select = false,
			columns = {
				permission = {
					enabled = false,
				},
				size = {
					enabled = false,
				},
			},
			win = {
				kinds = {
					split_left_most = {
						width = 48,
					},
				},
			},
		},
	},
})

vim.keymap.set("n", "<leader>b", function()
	require("fyler").toggle({ kind = "split_left_most" })
end, { desc = "Toggler Fyler Side[B]ar" })
