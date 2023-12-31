local nvimtree = require("nvim-tree")

vim.g.loaded = 1
vim.g.loaded_netwrPlugin = 1

nvimtree.setup({
  view = {
    width = 50,
  },
  renderer = {
    icons = {
      show = {
        file = false,
        folder = false,
      }
    }
  }
})

vim.keymap.set('n', '<leader><S-e>', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<leader>e', ':NvimTreeFocus<CR>')

