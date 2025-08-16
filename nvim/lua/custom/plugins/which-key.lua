-- Show pending keybinds.

return {
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 600
  end,
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup()
  end,
}
