local set = vim.keymap.set

-- Open parent directory in Oil
set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- clear search highlight
set("n", "<Esc>", "<cmd>nohlsearch<CR>")

set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })

-- prevent "c" replacing contents of clipboard
set("n", "c", '"_c', { noremap = true, silent = true })
set("n", "C", '"_C', { noremap = true, silent = true })

-- copy relative path of current file to clipboard
set("n", "<leader>y", function()
	vim.fn.setreg("+", vim.fn.expand("%"))
end)

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

set("n", "<leader>n", function()
	require("notify").dismiss({ silent = true, pending = true })
end, { desc = "Clear [N]otifications" })

set("n", "<leader>g", ":G | only<CR>", { desc = "[G]it" })

set("i", "<C-space>", vim.lsp.completion.get, { desc = "Trigger LSP Autocomplete" })
