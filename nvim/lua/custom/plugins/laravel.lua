return {
  'adalessa/laravel.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'tpope/vim-dotenv',
    'MunifTanjim/nui.nvim',
    'nvimtools/none-ls.nvim',
    'kevinhwang91/promise-async',
  },
  cmd = { 'Laravel' },
  keys = {
    { '<leader>la', ':Laravel artisan<cr>' },
    { '<leader>lr', ':Laravel routes<cr>' },
    { '<leader>lm', ':Laravel related<cr>' },
    { '<leader>lt', ':Artisan tinker<cr>' },
    {
      "gf",
      function()
          if require("laravel").app("gf").cursor_on_resource() then
              return "<cmd>Laravel gf<CR>"
          else
              return "gf"
          end
      end,
      noremap = false,
      expr = true,
    },
  },
  event = { 'VeryLazy' },
  opts = {
    features = {
      model_info = {
        enable = false,
      },
    }
  },
  config = true,
}
