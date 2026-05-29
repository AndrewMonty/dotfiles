local M = {}
local lsp_progress = {}
local git_cache = {
	cwd = nil,
	head = nil,
	updated_at = 0,
}

local severity = vim.diagnostic.severity

local mode_metadata = {
	n = { label = "NORMAL", color = "normal" },
	no = { label = "N-PENDING", color = "normal" },
	nov = { label = "N-PENDING", color = "normal" },
	noV = { label = "N-PENDING", color = "normal" },
	["no\22"] = { label = "N-PENDING", color = "normal" },
	niI = { label = "NORMAL", color = "normal" },
	niR = { label = "NORMAL", color = "normal" },
	niV = { label = "NORMAL", color = "normal" },
	nt = { label = "NORMAL", color = "normal" },
	v = { label = "VISUAL", color = "visual" },
	vs = { label = "VISUAL", color = "visual" },
	V = { label = "V-LINE", color = "visual" },
	Vs = { label = "V-LINE", color = "visual" },
	["\22"] = { label = "V-BLOCK", color = "visual" },
	["\22s"] = { label = "V-BLOCK", color = "visual" },
	s = { label = "SELECT", color = "select" },
	S = { label = "S-LINE", color = "select" },
	["\19"] = { label = "S-BLOCK", color = "select" },
	i = { label = "INSERT", color = "insert" },
	ic = { label = "INSERT", color = "insert" },
	ix = { label = "INSERT", color = "insert" },
	R = { label = "REPLACE", color = "replace" },
	Rc = { label = "REPLACE", color = "replace" },
	Rx = { label = "REPLACE", color = "replace" },
	Rv = { label = "V-REPLACE", color = "replace" },
	Rvc = { label = "V-REPLACE", color = "replace" },
	Rvx = { label = "V-REPLACE", color = "replace" },
	c = { label = "COMMAND", color = "command" },
	cv = { label = "EX", color = "command" },
	ce = { label = "EX", color = "command" },
	r = { label = "PROMPT", color = "command" },
	rm = { label = "MORE", color = "command" },
	["r?"] = { label = "CONFIRM", color = "command" },
	["!"] = { label = "SHELL", color = "terminal" },
	t = { label = "TERMINAL", color = "terminal" },
}

local function get_hl(name)
	local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
	if not ok then
		return {}
	end
	return hl
end

local function set_hl(name, opts)
	vim.api.nvim_set_hl(0, name, opts)
end

local function stl_escape(text)
	return tostring(text):gsub("%%", "%%%%")
end

local function mode_label(mode)
	return mode_metadata[mode] and mode_metadata[mode].label or mode:upper()
end

local function mode_color_key(mode)
	return mode_metadata[mode] and mode_metadata[mode].color or "normal"
end

local function current_mode_color(c)
	local key = mode_color_key(vim.api.nvim_get_mode().mode)
	return c[key] or c.fg
end

local function blend(fg, bg, alpha)
	if type(fg) ~= "number" or type(bg) ~= "number" then
		return bg
	end

	local fg_r = math.floor(fg / 0x10000) % 0x100
	local fg_g = math.floor(fg / 0x100) % 0x100
	local fg_b = fg % 0x100
	local bg_r = math.floor(bg / 0x10000) % 0x100
	local bg_g = math.floor(bg / 0x100) % 0x100
	local bg_b = bg % 0x100

	local r = math.floor(bg_r + (fg_r - bg_r) * alpha + 0.5)
	local g = math.floor(bg_g + (fg_g - bg_g) * alpha + 0.5)
	local b = math.floor(bg_b + (fg_b - bg_b) * alpha + 0.5)

	return r * 0x10000 + g * 0x100 + b
end

local function colors()
	local statusline = get_hl("StatusLine")
	local statusline_nc = get_hl("StatusLineNC")
	local normal = get_hl("Normal")
	local error = get_hl("DiagnosticError")
	local warn = get_hl("DiagnosticWarn")
	local ok = get_hl("DiagnosticOk")
	local hint = get_hl("DiagnosticHint")
	local info = get_hl("DiagnosticInfo")
	local visual = get_hl("Visual")
	local directory = get_hl("Directory")
	local string_hl = get_hl("String")
	local keyword = get_hl("Keyword")
	local statement = get_hl("Statement")
	local type_hl = get_hl("Type")
	local special = get_hl("Special")
	local identifier = get_hl("Identifier")
	local function_hl = get_hl("Function")

	local bg = statusline.bg or normal.bg or "none"
	local fg = statusline.fg or normal.fg
	local blend_bg = statusline.bg or normal.bg or statusline_nc.bg or 0x000000
	local mode_fg = bg ~= "none" and bg or normal.bg or statusline_nc.bg or 0x000000

	return {
		bg = bg,
		blend_bg = blend_bg,
		fg = fg,
		mode_fg = mode_fg,
		normal = function_hl.fg or identifier.fg or directory.fg or fg,
		insert = string_hl.fg or ok.fg or directory.fg or fg,
		visual = keyword.fg or statement.fg or visual.fg or fg,
		select = type_hl.fg or keyword.fg or fg,
		replace = error.fg or fg,
		command = warn.fg or statement.fg or fg,
		terminal = special.fg or info.fg or fg,
		diag = warn.fg or fg,
		error = error.fg or fg,
		lsp = info.fg or hint.fg or keyword.fg or fg,
		file_icon = directory.fg or special.fg or fg,
	}
end

local function apply_highlights()
	local c = colors()
	local mode = current_mode_color(c)
	local accent_bg = blend(mode, c.blend_bg, 0.26)

	set_hl("StatusLineMode", { fg = c.mode_fg, bg = mode, bold = true })
	set_hl("StatusLineModeSep", { fg = mode, bg = c.bg })
	set_hl("StatusLineModeToMuted", { fg = mode, bg = accent_bg })

	set_hl("StatusLineNormal", { fg = c.fg, bg = c.bg })
	set_hl("StatusLineMuted", { fg = mode, bg = accent_bg })
	set_hl("StatusLineMutedSep", { fg = accent_bg, bg = c.bg })
	set_hl("StatusLineFileIcon", { fg = c.file_icon, bg = c.bg })

	set_hl("StatusLineDiagPlain", { fg = c.diag, bg = c.bg })
	set_hl("StatusLineDiagError", { fg = c.error, bg = c.bg })
	set_hl("StatusLineLsp", { fg = c.lsp, bg = c.bg })
	set_hl("StatusLineScroll", { fg = mode, bg = accent_bg })
	set_hl("StatusLinePos", { fg = c.mode_fg, bg = mode, bold = true })
	set_hl("StatusLinePosSep", { fg = mode, bg = c.bg })
	set_hl("StatusLineMutedToMode", { fg = accent_bg, bg = mode })
end

local function refresh_highlights()
	apply_highlights()
	vim.cmd.redrawstatus()
end

local function git_head()
	local git_status = vim.b.gitsigns_status_dict
	if git_status and git_status.head and git_status.head ~= "" then
		return git_status.head
	end

	if vim.b.gitsigns_head and vim.b.gitsigns_head ~= "" then
		return vim.b.gitsigns_head
	end

	local cwd = vim.fn.getcwd(0)
	local now = vim.uv.now()
	if git_cache.cwd == cwd and now - git_cache.updated_at < 2000 then
		return git_cache.head
	end

	git_cache = {
		cwd = cwd,
		head = nil,
		updated_at = now,
	}

	local branch = vim.fn.systemlist({ "git", "branch", "--show-current" })[1]
	if vim.v.shell_error == 0 and branch and branch ~= "" then
		git_cache.head = branch
		return branch
	end

	local commit = vim.fn.systemlist({ "git", "rev-parse", "--short", "HEAD" })[1]
	if vim.v.shell_error == 0 and commit and commit ~= "" then
		git_cache.head = commit
	end

	return git_cache.head
end

local function mode_component(has_git)
	local mode = vim.api.nvim_get_mode().mode
	local right_sep = has_git and "" or "%#StatusLineModeSep#"

	return table.concat({
		"%#StatusLineModeSep#",
		"%#StatusLineMode# ",
		stl_escape(mode_label(mode)),
		" ",
		right_sep,
	})
end

local function git_component()
	local head = git_head()
	if not head then
		return ""
	end

	return table.concat({
		"%#StatusLineModeToMuted# ",
		"%#StatusLineMuted#",
		"  ",
		stl_escape(head),
		" ",
		"%#StatusLineMutedSep#",
	})
end

local function relative_path(path)
	local cwd = vim.fn.getcwd(0)
	local relative = vim.fs.relpath(cwd, path)

	if relative and relative ~= "" then
		return relative
	end

	return vim.fn.fnamemodify(path, ":~")
end

local function current_path()
	local filetype = vim.bo.filetype

	if filetype == "oil" then
		local ok, oil = pcall(require, "oil")
		if ok then
			local dir = oil.get_current_dir()
			if dir then
				return relative_path(dir)
			end
		end
	end

	if filetype == "netrw" and vim.b.netrw_curdir then
		return relative_path(vim.b.netrw_curdir)
	end

	local filename = vim.fn.expand("%:t")
	if filename == "" then
		return "[No Name]"
	end

	return filename
end

local function file_component()
	local filename = current_path()

	local icon = ""
	local ok, devicons = pcall(require, "nvim-web-devicons")
	if ok then
		local detected_icon = devicons.get_icon(filename, vim.fn.expand("%:e"), { default = true })
		icon = detected_icon or icon
	end

	return "%#StatusLineFileIcon#" .. icon .. "%#StatusLineNormal# " .. stl_escape(filename)
end

local function diagnostic_component()
	local errors = #vim.diagnostic.get(0, { severity = severity.ERROR })
	local warnings = #vim.diagnostic.get(0, { severity = severity.WARN })

	local parts = {}
	if errors > 0 then
		parts[#parts + 1] = "%#StatusLineDiagError# " .. errors
	end
	if warnings > 0 then
		parts[#parts + 1] = "%#StatusLineDiagPlain# " .. warnings
	end

	if #parts == 0 then
		return ""
	end

	return table.concat(parts, " ")
end

local function lsp_progress_component()
	local active = {}

	for _, progress in pairs(lsp_progress) do
		active[#active + 1] = progress
	end

	table.sort(active, function(a, b)
		return a.updated_at > b.updated_at
	end)

	if #active > 0 then
		local progress = active[1]
		local message = progress.message or progress.title or "working"

		if progress.percentage then
			message = message .. " " .. progress.percentage .. "%"
		end

		return "%#StatusLineLsp#  " .. stl_escape(progress.client .. ": " .. message)
	end

	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		return ""
	end

	local names = {}
	for _, client in ipairs(clients) do
		names[#names + 1] = client.name
	end

	table.sort(names)

	return "%#StatusLineLsp#  " .. stl_escape(table.concat(names, ","))
end

local function scroll_component()
	local current = vim.fn.line(".")
	local total = vim.fn.line("$")

	if current <= 1 then
		return table.concat({
			"%#StatusLineMutedSep#",
			"%#StatusLineScroll# Top ",
		})
	end

	if current >= total then
		return table.concat({
			"%#StatusLineMutedSep#",
			"%#StatusLineScroll# Bot ",
		})
	end

	local percentage = math.floor(current / total * 100)

	return table.concat({
		"%#StatusLineMutedSep#",
		"%#StatusLineScroll# ",
		percentage,
		"%% ",
	})
end

local function location_component()
	local line = vim.fn.line(".")
	local col = vim.fn.virtcol(".")

	return table.concat({
		"%#StatusLineMutedToMode# ",
		"%#StatusLinePos# ",
		line,
		":",
		col,
		" ",
		"%#StatusLinePosSep#",
	})
end

function M.render()
	local git = git_component()
	local left = {
		mode_component(git ~= ""),
		git,
		file_component(),
	}

	local diagnostics = diagnostic_component()
	local lsp = lsp_progress_component()
	local right = vim.tbl_filter(function(component)
		return component ~= ""
	end, {
		lsp,
		diagnostics,
	})
	local right_status = table.concat(right, " ")

	if right_status ~= "" then
		right_status = right_status .. " "
	end

	return table.concat(
		vim.tbl_filter(function(component)
			return component ~= ""
		end, left),
		" "
	) .. "%=" .. right_status .. scroll_component() .. location_component() .. "%#StatusLine#"
end

function M.setup()
	apply_highlights()

	vim.o.statusline = "%!v:lua.require('statusline').render()"

	local group = vim.api.nvim_create_augroup("custom-statusline", { clear = true })

	vim.api.nvim_create_autocmd("ColorScheme", {
		group = group,
		callback = function()
			vim.schedule(refresh_highlights)
		end,
	})

	vim.api.nvim_create_autocmd("ModeChanged", {
		group = group,
		callback = refresh_highlights,
	})

	vim.api.nvim_create_autocmd("LspProgress", {
		group = group,
		callback = function(ev)
			local data = ev.data or {}
			local params = data.params or {}
			local value = params.value or {}
			local client = data.client_id and vim.lsp.get_client_by_id(data.client_id)

			if not client then
				return
			end

			local key = client.id .. ":" .. tostring(params.token)

			if value.kind == "end" then
				lsp_progress[key] = nil
			else
				lsp_progress[key] = {
					client = client.name,
					message = value.message,
					percentage = value.percentage,
					title = value.title,
					updated_at = vim.uv.now(),
				}
			end

			vim.cmd.redrawstatus()
		end,
	})

	vim.api.nvim_create_autocmd({ "LspAttach", "LspDetach" }, {
		group = group,
		callback = function()
			vim.cmd.redrawstatus()
		end,
	})
end

return M
