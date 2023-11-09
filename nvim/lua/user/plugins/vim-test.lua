vim.cmd([[
  let g:test#strategy = "neovim"
  let g:test#neovim#start_normal = 1
  let g:test#neovim#term_position = "vert"
  let g:test#php#pest#executable = './vendor/bin/sail test --compact'
]])

vim.keymap.set('n', '<Leader>tn', ':TestNearest<CR>')
vim.keymap.set('n', '<Leader>tf', ':TestFile<CR>')
vim.keymap.set('n', '<Leader>ts', ':TestSuite<CR>')
vim.keymap.set('n', '<Leader>tl', ':TestLast<CR>')
vim.keymap.set('n', '<Leader>tv', ':TestVisit<CR>')
