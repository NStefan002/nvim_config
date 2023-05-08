return {
    -- Syntax highlithing and many more features
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require 'nvim-treesitter.configs'.setup {
                -- A list of parser names, or "all" (the four listed parsers should always be installed)
                ensure_installed = { "cpp", "javascript", "python", "html", "css", "java", "json", "c", "lua", "vim" },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = true,

                highlight = {
                    -- `false` will disable the whole extension
                    enable = true,
                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false,
                },
                indent = { enable = true, disable = { 'python' } },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<space>a',
                        node_incremental = '<space>a',
                        scope_incremental = '<space>x',
                        node_decremental = '<C-x>',
                    },
                },

                -- autoclose and autorename html tag
                autotag = {
                    enable = true,
                },
            }

            vim.treesitter.language.register('html', 'ejs')
            vim.treesitter.language.register('javascript', 'ejs')
        end
    },
    { 'nvim-treesitter/nvim-treesitter-context' },
    -- { 'nikvdp/ejs-syntax' },
}
