vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
	"https://github.com/nvim-telescope/telescope-ui-select.nvim",
})

require("telescope").setup({
	defaults = {
		prompt_prefix = "  ",
		layout_config = {
			prompt_position = "top",
		},
		sorting_strategy = "ascending",
		path_display = { truncate = 1 },
	},
	pickers = {
		find_files = {
			hidden = true,
		},
		oldfiles = {
			cwd_only = true,
		},
		lsp_references = {
			show_line = false,
		},
		lsp_definitions = {
			show_line = false,
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown(),
		},
	},
})

require("telescope").load_extension("ui-select")

local set = vim.keymap.set
local builtin = require("telescope.builtin")

-- Telescope search keybinds
set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch Open [B]uffers" })
set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
set("n", "<leader>sy", "Telescope git_file_history", { desc = "[S]earch Current File Histor[y]" })
set("n", "<leader>sm", builtin.marks, { desc = "[S]earch [M]arks" })

-- Use Telescope instead of quickfix for LSP related things
set("n", "gd", builtin.lsp_definitions, { desc = "[G]oto [D]efinition" })
set("n", "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })
set("n", "gr", builtin.lsp_references, { desc = "[G]oto [R]eferences" })
set("n", "gi", builtin.lsp_implementations, { desc = "[G]oto [I]mplementation" })
set("n", "gt", builtin.lsp_type_definitions, { desc = "[G]oto [T]ype Definition" })
set("n", "ga", vim.lsp.buf.code_action, { desc = "[G]oto LSP Code [A]ction" })
set("n", "<leader>ds", builtin.lsp_document_symbols, { desc = "[D]ocument [S]ymbols" })
set("n", "<leader>ws", builtin.lsp_dynamic_workspace_symbols, { desc = "[W]orkspace [S]ymbols" })
set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
set("n", "<leader>sF", function()
	builtin.find_files({
		no_ignore = true,
		prompt_title = "All Files",
	})
end, { desc = "[S]earch All [F]iles" })
