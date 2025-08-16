return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local lualine = require 'lualine'
    -- local auto_theme_custom = require 'lualine.themes.auto'
    -- for _, value in pairs(auto_theme_custom) do
    --   value.c.bg = 'none'
    -- end
    lualine.setup {
      options = {
        icons_enabled = true,
        -- theme = auto_theme_custom,
        theme = 'auto',
        component_separators = '',
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
        lualine_b = {
          {
            'branch',
            fmt = function(str)
              if vim.api.nvim_strwidth(str) > 23 then
                return ('%s…'):format(str:sub(1, 22))
              end

              return str
            end,
          },
          { 'diff' },
        },
        lualine_c = {
          {
            'filetype',
            icon_only = true,
            separator = '',
            padding = { left = 1, right = 0 },
          },
          { 'filename', path = 1 },
        },
        lualine_x = {
          'diagnostics',
        },
        lualine_z = {
          { 'location', separator = { right = '' }, left_padding = 1, right_padding = 1 },
        },
      },
    }
  end,
}
