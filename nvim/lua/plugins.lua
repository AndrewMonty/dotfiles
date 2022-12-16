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

packer.init()

local use = packer.use;

use('wbthomason/packer.nvim')
use('ryanoasis/vim-devicons')
use('tpope/vim-surround')
use('tpope/vim-commentary')
use('vv9k/vim-github-dark')
use('nelstrom/vim-visual-star-search')
use('nvim-lua/plenary.nvim')
use({
    'neovim/nvim-lspconfig',
    config = function()
        require('plugins.lspconfig')
    end,
})
use({
    'nvim-lualine/lualine.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
        require('plugins.lualine')
    end,
})
use({
    'nvim-tree/nvim-tree.lua',
    requires = {
        'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    config = function ()
        require('plugins.nvim-tree')
    end,
})
use({
    'nvim-telescope/telescope.nvim',
    requires = {
        { 'nvim-lua/plenary.nvim' },
        { 'kyazdani42/nvim-web-devicons' },
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        { 'nvim-telescope/telescope-live-grep-args.nvim' },
    },
    config = function()
        require('plugins.telescope')
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
        require('plugins.cmp')
    end,
})

