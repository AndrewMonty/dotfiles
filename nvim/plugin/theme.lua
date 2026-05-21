vim.pack.add({
	"https://github.com/f-person/auto-dark-mode.nvim",
})

local function set_transparent_highlights()
	local highlights = {
		"Normal",
		"NormalNC",
		"LineNr",
		"Folded",
		"NonText",
		"SpecialKey",
		"VertSplit",
		"SignColumn",
		"EndOfBuffer",
		"TablineFill",
		-- 'NormalFloat',
		"StatusLine",
	}

	for _, hl in ipairs(highlights) do
		vim.cmd.highlight(hl .. " guibg=NONE ctermbg=NONE")
	end
end

require("auto-dark-mode").setup({
	set_dark_mode = function()
		vim.o.background = "dark"
		vim.cmd.colorscheme("default")
		set_transparent_highlights()
	end,
	set_light_mode = function()
		vim.o.background = "light"
		vim.cmd.colorscheme("default")
		set_transparent_highlights()
	end,
})
