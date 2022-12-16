vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.mouse = 'a'
vim.opt.wrap = false
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.list = true -- enable the below listchars
vim.opt.listchars = { tab = '▸ ', trail = '·' }
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.fillchars:append({ eob = ' ' })
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.clipboard:append("unnamedplus")

local status, _ = pcall(vim.cmd, "colorscheme ghdark")
if not status then
    print("colorscheme ghdark not found")
    return
end

vim.cmd[[highlight Normal guibg=none]]
vim.cmd[[highlight NonText guibg=none]]

