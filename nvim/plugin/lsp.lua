vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
	ensure_installed = {
		"lua_ls",
		"stylua",
		"html",
		"cssls",
		"tailwindcss",
		"ts_ls",
		"eslint",
		"jsonls",
		"astro",
		-- "phpactor",
		"intelephense",
		"biome",
	},
})

vim.lsp.enable("lua_ls")
vim.lsp.enable("html")
vim.lsp.enable("cssls")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("ts_ls")
vim.lsp.enable("biome")
vim.lsp.enable("eslint")
vim.lsp.enable("jsonls")
vim.lsp.enable("astro")
-- vim.lsp.enable("phpactor")
vim.lsp.enable("intelephense")

-- use a swatch icon for color previews instead of changing text bg
vim.lsp.document_color.enable(true, nil, {
	style = "virtual",
})

-- prevent the built-in vim.lsp.completion autotrigger from selecting the first item
vim.opt.completeopt = { "menuone", "noselect", "popup" }

vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("autocompletion-sanitizer", { clear = true }),
	callback = function(ev)
		if vim.bo[ev.buf].buftype ~= "" then
			vim.bo[ev.buf].autocomplete = false
		end
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_completion", { clear = true }),
	callback = function(args)
		local client_id = args.data.client_id
		if not client_id then
			return
		end

		local client = vim.lsp.get_client_by_id(client_id)
		if client and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client_id, args.buf, {
				autotrigger = true,
			})
		end
	end,
})
