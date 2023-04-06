-- Lazy package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    -- Fuzzy finder
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        -- or                          , branch = '0.1.1',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    -- Syntax highlithing and many more features
    { "nvim-treesitter/nvim-treesitter",        build = ":TSUpdate" },
    { 'nvim-treesitter/playground' },
    { 'nvim-treesitter/nvim-treesitter-context' },
    -- undo history
    { 'mbbill/undotree' },
    -- Git help
    { 'tpope/vim-fugitive' },
    -- Status bar
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
    },
    -- color schemes
    { 'https://github.com/rafi/awesome-vim-colorschemes' },
    -- Language Server Protocol
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
                -- Optional
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    },
    -- auto close '"', ''', '{', '(', etc.
    { "windwp/nvim-autopairs" },
    -- multi-cursor mode (like in VSC)
    { "mg979/vim-visual-multi",                          branch = 'master' },
    -- todo highlither
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    -- file tree
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    },
    --
    -- nvim-tree extension
    {
        'antosha417/nvim-lsp-file-operations',
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-tree/nvim-tree.lua" },
        }
    },

    -- nice icons
    { 'nvim-tree/nvim-web-devicons' },
    -- commenting out code
    { 'preservim/nerdcommenter' },
    -- marking identation
    { "lukas-reineke/indent-blankline.nvim" },
    -- terminal windows
    { 'akinsho/toggleterm.nvim',            version = "*", config = true },

    -- live server (like VSC extension)
    {
        "aurum77/live-server.nvim",
        build = function()
            require "live_server.util".install()
        end,
        cmd = { "LiveServer", "LiveServerStart", "LiveServerStop" },
    },

    -- navigation bar for tags
    { 'preservim/tagbar' },

    -- good-looking diagnostics list
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    -- debugger support
    { 'mfussenegger/nvim-dap' },

    { "rcarriga/nvim-dap-ui",           dependencies = { "mfussenegger/nvim-dap" } },
    { 'theHamsta/nvim-dap-virtual-text' },

    -- documentation for writing Neovim config in Lua (setup called in after/plugin/lsp.lua file)
    { "folke/neodev.nvim" },

    -- color preview
    { 'NvChad/nvim-colorizer.lua' },

    -- winbar (like in VSC)
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
    },

    -- color picker (similar to VSC)
    {
        "ziontee113/color-picker.nvim",
        config = function()
            require("color-picker")
        end,
    },
}

local opts = {} -- default opts

require("lazy").setup(plugins, {})
