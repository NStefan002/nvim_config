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
                vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
                vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            end

            local schemes_candidates = {
                "gruvbox",
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
    }
}
