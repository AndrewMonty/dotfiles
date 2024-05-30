--  To check the current status of your plugins, run :Lazy

require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'karb94/neoscroll.nvim', -- "Animate" paging up and down so it's less jarring
  'farmergreg/vim-lastplace', -- Jump to last known cursor location in file
  'tpope/vim-dotenv', -- Load env files, useful for dadbod
  'folke/zen-mode.nvim', -- Hide distracting ui elements to focus on code
  -- { -- "gc" to comment visual regions/lines
  --   'numToStr/Comment.nvim',
  --   opts = {},
  -- },
  { -- highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'vimenter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
      }

      vim.keymap.set('n', '[h', ':Gitsigns prev_hunk<CR>')
      vim.keymap.set('n', ']h', ':Gitsigns next_hunk<CR>')
      vim.keymap.set('n', 'gs', ':Gitsigns stage_hunk<CR>')
      vim.keymap.set('n', 'gS', ':Gitsigns undo_stage_hunk<CR>')
      vim.keymap.set('n', 'gR', ':Gitsigns reset_hunk<CR>')
      vim.keymap.set('n', 'gp', ':Gitsigns preview_hunk<CR>')
      vim.keymap.set('n', 'gb', ':Gitsigns blame_line<CR>')
    end,
  },
  { -- Show pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 600
    end,
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').register {
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
      }
    end,
  },
  { -- Color theme
    -- dark options: 'nightfox', 'terafox', 'carbonfox', 'duskfox', 'nordfox',
    -- light options: 'dayfox', 'dawnfox'
    'EdenEast/nightfox.nvim',
    priority = 1000,
    opts = {
      options = {
        transparent = true,
      },
    },
  },
  -- {
  --   'f-person/auto-dark-mode.nvim',
  --   config = function()
  --     require('auto-dark-mode').setup {
  --       set_dark_mode = function()
  --         vim.cmd.colorscheme 'default'
  --       end,
  --       set_light_mode = function()
  --         vim.cmd.colorscheme 'dayfox'
  --       end,
  --     }
  --   end,
  -- },
  -- {
  --   'scottmckendry/cyberdream.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require('cyberdream').setup {
  --       -- Recommended - see "Configuring" below for more config options
  --       transparent = true,
  --       italic_comments = true,
  --       hide_fillchars = true,
  --       borderless_telescope = false,
  --       terminal_colors = true,
  --     }
  --     vim.cmd 'colorscheme cyberdream' -- set the colorscheme
  --   end,
  -- },
  {
    'stevearc/oil.nvim',
    opts = {
      float = {
        win_options = {
          winblend = 0,
        },
      },
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  { -- Smooth scrolling for window movement commands
    'karb94/neoscroll.nvim',
    opts = {
      easing_function = 'sine',
    },
  },
  {
    'rcarriga/nvim-notify',
    opts = {
      background_colour = '#000000',
    },
  },
  -- load plugins with more complicated config
  -- from their own files in custom/plugins/*.lua
  { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
