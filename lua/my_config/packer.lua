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

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use('nvim-treesitter/nvim-treesitter-context')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use('vim-airline/vim-airline')
    use('vim-airline/vim-airline-themes')
    use('https://github.com/rafi/awesome-vim-colorschemes')

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

    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    use {
        "mg979/vim-visual-multi",
        event = "BufReadPre"
    }

    -- todo highlither
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {
                --     -- your configuration comes here
                --     -- or leave it empty to use the default settings
                --     -- refer to the configuration section below
            }
        end
    }
    -- use {
    --     'abecodes/tabout.nvim',
    --     config = function()
    --         require('tabout').setup {
    --             tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
    --             backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
    --             act_as_tab = true, -- shift content if tab out is not possible
    --             act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
    --             default_tab = '<C-t>', -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
    --             default_shift_tab = '<C-d>', -- reverse shift default action,
    --             enable_backwards = true, -- well ...
    --             completion = true, -- if the tabkey is used in a completion pum
    --             tabouts = {
    --                 {open = "'", close = "'"},
    --                 {open = '"', close = '"'},
    --                 {open = '`', close = '`'},
    --                 {open = '(', close = ')'},
    --                 {open = '[', close = ']'},
    --                 {open = '{', close = '}'}
    --             },
    --             ignore_beginning = true, [> if the cursor is at the beginning of a filled element it will rather tab out than shift the content <]
    --             exclude = {} -- tabout will ignore these filetypes
    --         }
    --     end,
    --     wants = {'nvim-treesitter'}, -- or require if not used so far
    --     after = {'nvim-cmp'} -- if a completion plugin is using tabs load it before
    -- }

    -- file tree
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
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
end)
