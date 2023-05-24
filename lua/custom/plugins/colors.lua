return {
    -- color schemes
    {
        'rafi/awesome-vim-colorschemes',
        lazy = false,
        priority = 1000,
        config = function()
            -- colorschemes on startup
            if vim.g.neovide then
                -- colorscheme for neovide
                vim.cmd.colorscheme("hybrid_reverse")
            else
                vim.cmd.colorscheme("gotham256")
                -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
                -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            end

            local schemes_candidates = {
                "gruvbox",
                "ayu",
                "gotham256",
                "hybrid_reverse",
                "onedark",
                "deep-space",
                "carbonized-dark",
                "deus",
                "flattened_dark",
                "focuspoint",
                "lucid",
                "molokai",
                "yellow-moon",
                "PaperColor",
                "habamax",
            }

            local select_random_colorscheme = function()
                local random_scheme = schemes_candidates[math.random(1, #schemes_candidates)]
                print(random_scheme)
                vim.cmd.colorscheme(random_scheme)
                vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
                vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            end

            vim.keymap.set("n", "<leader>col", select_random_colorscheme)
        end
    },
    {
        "xiyaowong/transparent.nvim",
        lazy = false,
        config = function()
            require("transparent").setup({
                groups = { -- table: default groups
                    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
                    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
                    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
                    'SignColumn', 'CursorLineNr', 'EndOfBuffer',
                },
                extra_groups = { 'NormalFloat', 'NvimTreeNormal' }, -- table: additional groups that should be cleared
                exclude_groups = {},                                -- table: groups you don't want to clear

            })

            if vim.g.neovide then
                vim.cmd('TransparentDisable')
            else
                vim.cmd('TransparentEnable')
            end
        end
    }
}
