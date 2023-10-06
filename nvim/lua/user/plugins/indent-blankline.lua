require('ibl').setup({
  scope = {
    enabled = false
  },
  exclude = {
    filetypes = {
      'help',
      'terminal',
      'dashboard',
      'packer',
      'lspinfo',
      'TelescopePrompt',
      'TelescopeResults',
    },
    buftypes = {
      'terminal',
      'NvimTree',
    },
  },
})
