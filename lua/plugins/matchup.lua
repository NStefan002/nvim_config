return {
    "andymass/vim-matchup",
    event = "VeryLazy",
    init = function()
        vim.o.matchpairs = "(:),{:},[:]"
        vim.g.matchup_enabled = 1
        vim.g.matchup_matchparen_enabled = 1
        vim.g.matchup_matchparen_deferred = 1
        vim.g.matchup_matchparen_offscreen = { method = "none" }
        vim.g.matchup_transmute_enabled = 0
        vim.g.matchup_surround_enabled = 1
    end,
    config = function()
        vim.api.nvim_create_autocmd("BufReadPre", {
            group = vim.api.nvim_create_augroup("MatchparenSurround", {}),
            pattern = {
                "*.html",
                "*.css",
                "*.ejs",
            },
            callback = function()
                vim.b.matchup_matchparen_hi_surround_always = 1
            end,
        })

        vim.api.nvim_create_autocmd({ "ColorScheme", "BufEnter" }, {
            group = vim.api.nvim_create_augroup("MatchParenColor", {}),
            pattern = "*",
            callback = function()
                vim.api.nvim_set_hl(0, "MatchParenCur", {
                    bg = "none",
                })
                vim.api.nvim_set_hl(0, "MatchWordCur", {
                    bg = "none",
                    italic = true,
                    underline = true,
                })
            end,
        })
    end,
}
