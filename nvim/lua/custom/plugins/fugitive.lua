return {
  'tpope/vim-fugitive', -- Awesome Git GUI
  opts = {},
  config = function()
    vim.keymap.set('n', '<leader>G', ':G | only<CR>', { desc = '[G]it' })
  end,
}
