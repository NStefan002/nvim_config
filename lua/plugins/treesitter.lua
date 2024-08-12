return {
    -- Syntax highlithing and many more features
    {
        "nvim-treesitter/nvim-treesitter",
        -- lazy = false,
        build = ":TSUpdate",
        event = "VeryLazy",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "bash",
                    "c",
                    "cmake",
                    "cpp",
                    "css",
                    "diff",
                    "gitcommit",
                    "gitignore",
                    "go",
                    "haskell",
                    "html",
                    "java",
                    "javascript",
                    "json",
                    "lua",
                    "make",
                    "markdown",
                    "markdown_inline",
                    "python",
                    "regex",
                    "toml",
                    "vim",
                    "vimdoc",
                    "yaml",
                },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = true,

                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                    -- disable for larger files
                    disable = function(lang, buf)
                        local max_filesize = 50 * 1024 -- 50 KB
                        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                },
                indent = { enable = true, disable = { "python", "markdown" } },
                incremental_selection = {
                    enable = false,
                },

                -- autoclose and autorename html tag
                autotag = {
                    enable = true,
                },

                -- see https://github.com/andymass/vim-matchup?tab=readme-ov-file#tree-sitter-integration
                matchup = {
                    enable = true,
                },
            })

            -- temporary fix for school projects
            vim.treesitter.language.register("html", "ejs")
            vim.treesitter.language.register("javascript", "ejs")
            vim.treesitter.language.register("cpp", "conf")
            vim.treesitter.language.register("cpp", "fsharp")
            vim.filetype.add({ extension = { ypp = "ypp" } })
            vim.treesitter.language.register("cpp", "ypp")
            vim.treesitter.language.register("cpp", "lex")
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        opts = {
            enable = true, -- :TSContextToggle
            max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
            min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
            line_numbers = true,
            multiline_threshold = 5, -- Maximum number of lines to show for a single context
            trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
            mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
            -- Separator between context and content. Should be a single character string, like '-'.
            -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
            separator = "󰮸",
            zindex = 20, -- The Z-index of the context window
            on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
        },
    },
}
