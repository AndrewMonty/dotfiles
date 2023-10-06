require('mason').setup()
require('mason-lspconfig').setup({ automatic_installation = true });

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

require('lspconfig').intelephense.setup({ capabilities = capabilities })

require('lspconfig').html.setup({ capabilities = capabilities })

require('lspconfig').emmet_ls.setup({ capabilities = capabilities })

require('lspconfig').tailwindcss.setup({ capabilities = capabilities })

require('null-ls').setup({
    sources = {
        require('null-ls').builtins.diagnostics.eslint_d.with({
            condition = function(utils)
                return utils.root_has_file({ '.eslintrc.js' })
            end,
        }),
        require('null-ls').builtins.diagnostics.trail_space.with({
            disabled_filetypes = { 'NvimTree' }
        }),
        require('null-ls').builtins.formatting.eslint_d.with({
            condition = function(utils)
                return utils.root_has_file({ '.eslintrc.js' })
            end,
        }),
        require('null-ls').builtins.formatting.prettierd,
    },
})

require('mason-null-ls').setup({ automatic_installation = true })

vim.keymap.set('n', '<leader>ca', ':CodeActionMenu<CR>')
vim.keymap.set('v', '<leader>ca', ':CodeActionMenu<CR>')
vim.keymap.set('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { buffer = bufnr })
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { buffer = bufnr })
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { buffer = bufnr })
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { buffer = bufnr })
vim.keymap.set('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { buffer = bufnr })
vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { buffer = bufnr })
vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>', { buffer = bufnr })

vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.format({ timeout_ms = 5000 }) end, {})

vim.diagnostic.config({
    virtual_text = false,
    float = {
        source = true,
    },
})

vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
