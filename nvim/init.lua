require("vim._core.ui2").enable({})

require("options")
require("keymap")

vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		require("statusline").setup()
	end,
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ timeout = 300 })
	end,
})

local select = vim.ui.select

---@diagnostic disable-next-line: duplicate-set-field
vim.ui.select = function(items, opts, on_choice)
	opts = opts or {}

	if opts.kind == "codeaction" then
		local function score(item)
			local text = (item.title or item.command or ""):lower()
			local client = type(item.client) == "table" and item.client.name or ""
			local n = text:find("import", 1, true) and -10 or 0

			if text:find("update import", 1, true) then
				n = n - 20
			elseif text:find("add import", 1, true) then
				n = n - 10
			end

			if text:find("eslint", 1, true) or client:lower():find("eslint", 1, true) then
				n = n + 50
			end

			return n
		end

		local sorted_items = {}
		for idx, item in ipairs(items) do
			sorted_items[idx] = { item = item, score = score(item), idx = idx }
		end

		table.sort(sorted_items, function(a, b)
			return a.score == b.score and a.idx < b.idx or a.score < b.score
		end)

		for idx, entry in ipairs(sorted_items) do
			items[idx] = entry.item
		end

		return select(items, opts, on_choice)
	end

	return select(items, opts, on_choice)
end
