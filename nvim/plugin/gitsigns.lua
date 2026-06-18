vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

require("gitsigns").setup({
	on_attach = function(bufnr)
		local gitsigns = require("gitsigns")
		local set = vim.keymap.set
		local opts = { buffer = bufnr }

		set("n", "<leader>h", function()
			gitsigns.nav_hunk("next")
		end, vim.tbl_extend("force", opts, { desc = "Next Git hunk" }))

		set("n", "gs", gitsigns.stage_hunk, vim.tbl_extend("force", opts, { desc = "Stage/unstage Git hunk" }))
		set("v", "gs", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, vim.tbl_extend("force", opts, { desc = "Stage/unstage Git selection" }))
		set("n", "gb", gitsigns.blame_line, vim.tbl_extend("force", opts, { desc = "Git blame line" }))
		set("n", "gp", gitsigns.preview_hunk, vim.tbl_extend("force", opts, { desc = "Preview Git hunk" }))
	end,
})
