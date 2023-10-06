vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
    return
end

packer.init({
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'single' })
        end,
    }
})

local use = packer.use;

use('ThePrimeagen/vim-be-good')

use('wbthomason/packer.nvim')

use('ryanoasis/vim-devicons')

use('tpope/vim-surround')

use('tpope/vim-commentary')

use('nelstrom/vim-visual-star-search')

use('nvim-lua/plenary.nvim')

use('farmergreg/vim-lastplace')

use('tpope/vim-sleuth')

use('tpope/vim-repeat')

use({
  'windwp/nvim-autopairs',
  config = function()
    require('nvim-autopairs').setup()
  end,
})

use({
    'nvim-treesitter/nvim-treesitter',
    run = function()
        require('nvim-tresitter.install').update({ with_sync = true })
    end,
    requires = {
        'JoosepAlviste/nvim-ts-context-commentstring',
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/playground',
    },
    config = function ()
        require('user.plugins.treesitter')
    end,
})

use({
    'nvim-lualine/lualine.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
        require('user.plugins.lualine')
    end,
})

use({
    'nvim-tree/nvim-tree.lua',
    requires = {
        'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    config = function ()
        require('user.plugins.nvim-tree')
    end,
})

use({
    'nvim-telescope/telescope.nvim',
    after = 'nightfox.nvim',
    requires = {
        { 'nvim-lua/plenary.nvim' },
        { 'kyazdani42/nvim-web-devicons' },
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        { 'nvim-telescope/telescope-live-grep-args.nvim' },
    },
    config = function()
        require('user.plugins.telescope')
    end,
})

use({
    'karb94/neoscroll.nvim',
    config = function ()
        require('neoscroll').setup()
    end,
})

use({
    'lewis6991/gitsigns.nvim',
    config = function ()
        require('user.plugins.gitsigns')
    end,
})

use({
    'numToStr/FTerm.nvim',
    config = function ()
        require'FTerm'.setup({
            border = 'single',
        })
        vim.keymap.set('n', '<M-p>', '<CMD>lua require("FTerm").toggle()<CR>')
        vim.keymap.set('t', '<M-p>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
    end,
})

use({
    'neovim/nvim-lspconfig',
    requires = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'jose-elias-alvarez/null-ls.nvim',
        'jayp0521/mason-null-ls.nvim',
    },
    config = function()
        require('user.plugins.lspconfig')
    end,
})

use({
    'hrsh7th/nvim-cmp',
    requires = {
        'L3MON4D3/LuaSnip',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-path',
        'onsails/lspkind-nvim',
        'saadparwaiz1/cmp_luasnip',
    },
    config = function()
        require('user.plugins.cmp')
    end,
})

use({
  'sickill/vim-pasta',
  config = function()
    vim.g.pasta_disabled_filetypes = { 'fugitive' }
  end,
})

-- use({
--   'projekt0n/github-nvim-theme',
--   config = function()
--     require('github-theme').setup({
--         options = {
--             transparent = false,
--             darken = {
--                 floats = true,
--                 sidebars = {
--                     enable = true,
--                     list = { "terminal", "NvimTree", "term", "packer" }
--                 },
--             }
--         },
--     })

--     vim.cmd('colorscheme github_light')
--   end
-- })

use({
    'EdenEast/nightfox.nvim',
    config = function()
        require('nightfox').setup({
            options = {
                transparent = true,
            },
        })

        vim.cmd("colorscheme carbonfox")
        -- vim.cmd("colorscheme dawnfox")
    end,
})

-- use({
--     'folke/tokyonight.nvim',
--     config = function ()
--         vim.cmd("colorscheme tokyonight")
--     end,
-- })

use({
    'lukas-reineke/indent-blankline.nvim',
    config = function()
        require('user/plugins/indent-blankline')
    end,
})

use('RRethy/nvim-align')

use({
    'vim-test/vim-test',
    config = function ()
        require('user/plugins/vim-test')
    end,
})
