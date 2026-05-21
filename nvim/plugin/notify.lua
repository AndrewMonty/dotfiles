vim.pack.add({
	"https://github.com/rcarriga/nvim-notify",
})

require("notify").setup({
	merge_duplicates = true,
	background_colour = "#000000",
	render = "compact",
})
