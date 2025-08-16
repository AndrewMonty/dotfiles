-- collection of various small independent plugins/modules

return {
  'echasnovski/mini.nvim',
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  config = function()
    -- better around/inside textobjects
    --
    -- examples:
    --  - va)  - [v]isually select [a]round [)]paren
    --  - yinq - [y]ank [i]nside [n]ext [']quote
    --  - ci'  - [c]hange [i]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [s]urround [a]dd [i]nner [w]ord [)]paren
    -- - sd'   - [s]urround [d]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup {
      respect_selection_type = true,
      custom_surroundings = {
        T = {
          input = { '<(%w+)[^<>]->.-</%1>', '^<()%w+().*</()%w+()>$' },
          output = function()
            local tag_name = MiniSurround.user_input 'Tag name'
            if tag_name == nil then
              return nil
            end
            return { left = tag_name, right = tag_name }
          end,
        },
      },
    }

    -- toggle line/block comments
    -- - gcc - toggle [c]omment line
    require('mini.comment').setup {
      options = {
        custom_commentstring = function()
          return require('ts_context_commentstring.internal').calculate_commentstring() or vim.bo.commentstring
        end,
      },
    }

    require('mini.pairs').setup()

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    -- local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    -- statusline.setup { use_icons = vim.g.have_nerd_font }

    -- ---@diagnostic disable-next-line: duplicate-set-field
    -- statusline.section_git = function()
    --   local branch = vim.b.gitsigns_head or ''
    --   return ' ' .. string.format('%s', branch)
    -- end
    -- ---@diagnostic disable-next-line: duplicate-set-field
    -- statusline.section_diff = function()
    --   local status = vim.b.gitsigns_status or ''
    --   return string.format('%s', status)
    -- end
    -- ---@diagnostic disable-next-line: duplicate-set-field
    -- statusline.section_lsp = function()
    --   return ''
    -- end
    -- ---@diagnostic disable-next-line: duplicate-set-field
    -- statusline.section_location = function()
    --   return '%l/%v'
    -- end
    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
