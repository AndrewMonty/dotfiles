local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = " "

opt.number = true -- show line numbers
opt.relativenumber = true -- Make line numbers relative to cursor
opt.mouse = "a" -- Enable mouse mode, can be useful for resizing splits for example!
opt.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim.
opt.autoindent = true -- Enable auto indentation
opt.expandtab = true -- Use spaces instead of tabs
opt.tabstop = 2 -- Number of spaces for a tab
opt.softtabstop = 2 -- Number of spaces for a tab when editing
opt.shiftwidth = 2 -- Number of spaces for autoindent
opt.shiftround = true -- Round indent to multiple of shiftwidth
opt.ignorecase = true -- Case-insensitive searching by default
opt.smartcase = true -- UNLESS \C or one or more capital letters in the search term
opt.signcolumn = "yes:1" -- Keep signcolumn on by default
opt.list = true -- Display trailing whitespace characters
opt.listchars = { tab = "» ", leadtab = "  ", trail = "·", nbsp = "␣" }
opt.cursorline = true -- Show which line your cursor is on
opt.scrolloff = 5 -- Minimal number of screen lines to keep above and below the cursor.
opt.undofile = true -- Enable persistent undo history
opt.showmode = false -- Don't show the mode, since it's already in the status line
opt.fillchars = { eob = " " } -- hide ~ after the end of the buffer
opt.wrap = false -- don't wrap lines longer than the buffer
opt.splitright = true
opt.splitbelow = true
opt.completeopt:append("noselect") -- don't automatically select first autocomplete option

vim.cmd.filetype("plugin indent on") -- Enable filetype detection, plugins, and indentation
