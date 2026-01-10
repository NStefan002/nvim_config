return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        branch = "main",
        config = function()
            require("nvim-treesitter").setup({})

            require("nvim-treesitter").install({
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
                "jsdoc",
                "json",
                "lua",
                "make",
                "markdown",
                "markdown_inline",
                "python",
                "regex",
                "sql",
                "toml",
                "vim",
                "vimdoc",
                "yaml",
            })

            -- on main branch, treesitter isn't started automatically
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("TSAutoInstall", {}),
                pattern = "*",
                callback = function(event)
                    -- make sure nvim-treesitter is loaded
                    local ok, nvim_treesitter = pcall(require, "nvim-treesitter")
                    if not ok then
                        return
                    end

                    local parsers = require("nvim-treesitter.parsers")

                    local ft = vim.bo[event.buf].ft
                    local lang = vim.treesitter.language.get_lang(ft)
                    if not parsers[lang] or not nvim_treesitter.install then
                        return
                    end

                    -- auto install missing parser
                    nvim_treesitter.install({ lang }):wait()

                    -- start treesitter for the buffer
                    pcall(vim.treesitter.start, event.buf)
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
                    vim.wo[0][0].foldmethod = "expr"
                end,
                desc = "Auto install treesitter parsers",
            })

            -- NOTE: temporary fix for school projects
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
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "VeryLazy",
        branch = "main",
        init = function()
            vim.g.no_plugin_maps = true
        end,
        config = function()
            require("nvim-treesitter-textobjects").setup({
                select = {
                    lookahead = true,
                    selection_modes = {
                        ["@function.outer"] = "V",
                    },
                    include_surrounding_whitespace = false,
                },
            })

            vim.keymap.set({ "x", "o" }, "if", function()
                require("nvim-treesitter-textobjects.select").select_textobject(
                    "@function.inner",
                    "textobjects"
                )
            end, { desc = "select [i]nside [f]unction" })
            vim.keymap.set({ "x", "o" }, "af", function()
                require("nvim-treesitter-textobjects.select").select_textobject(
                    "@function.outer",
                    "textobjects"
                )
            end, { desc = "select [a]round [f]unction" })
            vim.keymap.set("n", "<leader>]", function()
                require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
            end, { desc = "swap next parameter" })
            vim.keymap.set("n", "<leader>[", function()
                require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.outer")
            end, { desc = "swap previous parameter" })
        end,
    },
}
