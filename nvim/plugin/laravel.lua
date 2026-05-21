vim.pack.add({
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-neotest/nvim-nio",
	"https://github.com/adalessa/laravel.nvim",
})

local laravel = require("laravel")

laravel.setup({
	features = {
		pickers = {
			provider = "telescope",
		},
	},
})

vim.g.Laravel = laravel

local set = vim.keymap.set

set("n", "<leader>ll", function()
	Laravel.pickers.laravel()
end, { desc = "[L]aravel [L]ist Picker" })
set("n", "<leader>la", function()
	Laravel.pickers.artisan()
end, { desc = "[L]aravel [A]rtisan" })
set("n", "<leader>lr", function()
	Laravel.pickers.routes()
end, { desc = "[L]aravel [R]outes" })
set("n", "<leader>lm", function()
	Laravel.pickers.make()
end, { desc = "[L]aravel [M]ake" })
set("n", "gf", function()
	local ok, res = pcall(function()
		if Laravel.app("gf").cursorOnResource() then
			return "<cmd>lua Laravel.commands.run('gf')<cr>"
		end
	end)
	if not ok or not res then
		return "gf"
	end
	return res
end, { desc = "Laravel: Go to Resource", expr = true, noremap = true })
