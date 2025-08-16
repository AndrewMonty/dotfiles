-- highlight todo, notes, etc in comments

return {
  'folke/todo-comments.nvim',
  event = 'vimenter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    signs = true,
    -- keywords = {
    --   NOTE = { icon = 'ℹ ', color = 'hint', alt = { 'INFO' } },
    -- },
  },
}
