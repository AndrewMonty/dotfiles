vim.pack.add({
	"https://github.com/nvim-mini/mini.icons",
	"https://github.com/A7Lavinraj/fyler.nvim",
})

require("fyler").setup()

vim.keymap.set("n", "<leader>b", function()
	require("fyler").toggle({ kind = "split_left_most" })
end, { desc = "Toggler Fyler Side[B]ar" })
