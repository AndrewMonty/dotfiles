return {
  'rcarriga/nvim-notify',
  config = function()
    require("notify").setup({
      merge_duplicates = true,
      background_colour = '#000000',
      render = 'compact',
    })

    local clear_notifications = function()
      require("notify").dismiss({ silent = true, pending = true })
    end

    vim.keymap.set('n', '<leader>n', clear_notifications, { desc = 'Clear [N]otifications' })
  end,
}
