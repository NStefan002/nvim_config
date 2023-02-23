-- My Note: Tool for installing plugins

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                           , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- Syntax highlithing and many more features
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use('nvim-treesitter/nvim-treesitter-context')

    -- undo history
    use('mbbill/undotree')

    -- Git help
    use('tpope/vim-fugitive')

    -- Status bar
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- color schemes
    use('https://github.com/rafi/awesome-vim-colorschemes')

    -- Language Server Protocol
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            { 'williamboman/mason.nvim' }, -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' }, -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'hrsh7th/cmp-buffer' }, -- Optional
            { 'hrsh7th/cmp-path' }, -- Optional
            { 'saadparwaiz1/cmp_luasnip' }, -- Optional
            { 'hrsh7th/cmp-nvim-lua' }, -- Optional

            -- Snippets
            { 'L3MON4D3/LuaSnip' }, -- Required
            { 'rafamadriz/friendly-snippets' }, -- Optional
        }
    }

    -- auto close '"', ''', '{', '(', etc.
    use "windwp/nvim-autopairs"

    -- multi-cursor mode (like in VSC)
    use { "mg979/vim-visual-multi", branch = 'master' }
    -- event = "BufReadPre"

    -- todo highlither
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
    }
    -- use {
    --     'abecodes/tabout.nvim',
    --     config = function()
    -- }


    -- file tree
    use {
        'nvim-tree/nvim-tree.lua',
        requires = { 'nvim-tree/nvim-web-devicons' }, -- optional, for file icons
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    -- nice icons
    use 'nvim-tree/nvim-web-devicons'
    -- commenting out code
    use 'preservim/nerdcommenter'
    -- marking identation
    use "lukas-reineke/indent-blankline.nvim"

    -- terminal windows
    use { "akinsho/toggleterm.nvim", tag = '*' }

    -- live server (like VSC extension)
    use({
        "aurum77/live-server.nvim",
        run = function()
            require "live_server.util".install()
        end,
        cmd = { "LiveServer", "LiveServerStart", "LiveServerStop" },
    })

    -- navigation bar for tags
    use 'preservim/tagbar'

    -- good-looking diagnostics list
    use {
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons",
    }

    -- debugger support
    use 'mfussenegger/nvim-dap'
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
    use 'theHamsta/nvim-dap-virtual-text'

    -- ChatGPT
    use({
        "jackMort/ChatGPT.nvim",
        requires = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        }
    })
end)
