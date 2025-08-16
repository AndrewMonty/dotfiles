--  To check the current status of your plugins, run :Lazy

require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'farmergreg/vim-lastplace', -- Jump to last known cursor location in file
  'tpope/vim-dotenv', -- Load env files, useful for dadbod
  'folke/zen-mode.nvim', -- Hide distracting ui elements to focus on code
  'delphinus/vim-firestore', -- Syntax highlighting for Firebase rules
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
