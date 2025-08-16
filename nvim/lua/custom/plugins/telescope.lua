return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make', -- only runs on Lazy install/update

      -- used to determine whether this plugin should be installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    {
      'dimaportenko/telescope-simulators.nvim',
      config = function()
        require('simulators').setup {
          android_emulator = true,
          apple_simulator = true,
        }
      end,
    },
    {
      'isak102/telescope-git-file-history.nvim',
      dependencies = { 'tpope/vim-fugitive' },
    },
    {
      'nvim-telescope/telescope-frecency.nvim',
    },
  },
  config = function()
    local gfh_actions = require('telescope').extensions.git_file_history.actions

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      defaults = {
        prompt_prefix = '  ',
        layout_config = {
          prompt_position = 'top',
        },
        sorting_strategy = 'ascending',
        path_display = { truncate = 1 },
      },
      pickers = {
        oldfiles = {
          cwd_only = true,
        },
        lsp_references = {
          show_line = false,
        },
        lsp_definitions = {
          show_line = false,
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        git_file_history = {
          -- Keymaps inside the picker
          mappings = {
            i = {
              ['<C-g>'] = gfh_actions.open_in_browser,
            },
            n = {
              ['<C-g>'] = gfh_actions.open_in_browser,
            },
          },

          -- The command to use for opening the browser (nil or string)
          -- If nil, it will check if xdg-open, open, start, wslview are available, in that order.
          browser_command = nil,
        },
        frecency = {
          theme = 'dropdown',
          workspace = 'CWD',
          cwd_only = true,
          prompt_title = 'Frecent Files',
          previewer = false,
          layout_config = {
            width = function(_, max_columns, _)
              return math.min(max_columns, 80)
            end,
          },
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'git_file_history')
    pcall(require('telescope').load_extension, 'frecency')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    local extensions = require('telescope').extensions;
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    -- vim.keymap.set('n', '<leader>s.', extensions.frecency.frecency, { desc = '[S]earch Frecent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch Open [B]uffers' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>sy', 'Telescope git_file_history', { desc = '[S]earch Current File Histor[y]' })
    vim.keymap.set('n', '<leader>sm', builtin.marks, { desc = '[S]earch [M]arks' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        -- winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })

    -- Search all files, including gitignored ones
    vim.keymap.set('n', '<leader>sF', function()
      builtin.find_files {
        no_ignore = true,
        prompt_title = 'All Files',
      }
    end, { desc = '[S]earch All [F]iles' })
  end,
}
