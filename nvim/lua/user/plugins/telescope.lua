local telescope = require('telescope')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

telescope.setup({
    defaults = {
        -- prompt_prefix = ' 
        path_display = { truncate = 1 },
        layout_config = {
            prompt_position = 'top',
            vertical = { width = 0.5 },
        },
        sorting_strategy = 'ascending',
        file_ignore_patterns = { '.git/' },
    },
    pickers = {
        find_files = {
            hidden = true,
        },
        oldfiles = {
            prompt_title = 'History',
            cwd_only = true,
        },
    },
})

vim.keymap.set('n', '<leader>f', [[<cmd>lua require('telescope.builtin').find_files()<CR>]])
vim.keymap.set('n', '<leader>F', [[<cmd>lua require('telescope.builtin').find_files({ no_ignore = true, prompt_title = 'All Files' })<CR>]])
vim.keymap.set('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
vim.keymap.set('n', '<leader>g', [[<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>]])
vim.keymap.set('n', '<leader>h', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])
vim.keymap.set('n', '<leader>s', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]])
