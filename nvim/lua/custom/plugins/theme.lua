return {
  {
    'EdenEast/nightfox.nvim',
    -- dark options: 'nightfox', 'terafox', 'carbonfox', 'duskfox', 'nordfox',
    -- light options: 'dayfox', 'dawnfox'
    priority = 1000,
    opts = {
      options = {
        transparent = true,
      },
    },
  },
  {
    'folke/tokyonight.nvim',
    -- dark options: 'tokyonight', 'tokyonight-night', 'tokyonight-storm', 'tokyonight-moon',
    -- light options: 'tokyonight-day',
    lazy = false,
    priority = 1000,
    opts = {
      options = {
        transparent = true,
        italic = false,
      },
    },
  },
  {
    'f-person/auto-dark-mode.nvim',
    config = function()
      require('auto-dark-mode').setup {
        set_dark_mode = function()
          vim.o.background = 'dark'
          vim.cmd.colorscheme 'catppuccin-macchiato'
        end,
        set_light_mode = function()
          vim.o.background = 'light'
          vim.cmd.colorscheme 'catppuccin-latte'
        end,
      }
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    opts = {
      styles = {
        italic = false,
        transparency = true,
      },
    },
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        transparent_background = true,
        no_italic = true,
        integrations = {
          notify = true,
        },
        highlight_overrides = {
          macchiato = function(colors)
            return {
              CursorLine = { bg = 'NONE' },
              Visual = { bg = '#383838' },
              NormalFloat = { bg = '#000000' },
              TelescopeNormal = { bg = 'NONE' }
            }
          end,
          latte = function(colors)
            return {
              CursorLine = { bg = 'NONE' },
              Visual = { bg = '#DFDFDF' },
              NormalFloat = { bg = '#FFFFFF' },
              TelescopeNormal = { bg = 'NONE' }
            }
          end,
        },
      }

      vim.cmd.colorscheme 'catppuccin-macchiato'
    end,
  },
}
