return {
    'vim-test/vim-test',
    opts = {},
    config = function()
      vim.cmd([[
        let g:test#strategy = "neovim"
        let g:test#preserve_screen = 1
        let g:test#neovim#start_normal = 1
        let g:test#neovim#term_position = "vert"
        " let g:test#php#pest#executable = './vendor/bin/sail test --compact'
        let g:test#go#gotest#executable = "gotest"
      ]])

      vim.keymap.set('n', '<Leader>tn', ':TestNearest<CR>', { desc = '[T]est [N]earest' })
      vim.keymap.set('n', '<Leader>vtn', ':TestNearest -v<CR>', { desc = '[V]erbose [T]est [N]earest' })
      vim.keymap.set('n', '<Leader>tf', ':TestFile<CR>', { desc = '[T]est [F]ile' })
      vim.keymap.set('n', '<Leader>vtf', ':TestFile -v<CR>', { desc = '[V]erbose [T]est [F]ile' })
      vim.keymap.set('n', '<Leader>ts', ':TestSuite<CR>', { desc = '[T]est [S]uite' })
      vim.keymap.set('n', '<Leader>vts', ':TestSuite -v<CR>', { desc = '[V]erbose [T]est [S]uite' })
      vim.keymap.set('n', '<Leader>tl', ':TestLast<CR>', { desc = '[T]est [L]ast' })
      vim.keymap.set('n', '<Leader>vtl', ':TestLast -v<CR>', { desc = '[V]erbose [T]est [L]ast' })
      vim.keymap.set('n', '<Leader>tv', ':TestVisit<CR>', { desc = '[T]est [V]isit' })
    end,
}
