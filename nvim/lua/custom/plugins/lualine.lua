return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local lualine = require 'lualine'
    local auto_theme_custom = require 'lualine.themes.auto'
    for _, value in pairs(auto_theme_custom) do
      value.c.bg = 'none'
    end
    lualine.setup {
      options = {
        icons_enabled = true,
        theme = auto_theme_custom,
        section_separators = '',
        component_separators = '',
      },
      sections = {
        lualine_a = { { 'mode' } },
        lualine_b = { 'branch', 'diff' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = {
          {
            'filetype',
            icon_only = true,
            separator = '',
            padding = { left = 1, right = 0 },
          },
          'diagnostics',
        },
      },
    }
  end,
}
