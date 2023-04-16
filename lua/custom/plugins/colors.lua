return {
    -- color schemes
    {
        'rafi/awesome-vim-colorschemes',
        lazy = false,
        priority = 1000,
        config = function()
            -- colorscheme on start
            if vim.g.neovide then
                -- colorscheme for neovide
                vim.cmd.colorscheme("hybrid_reverse")
            else
                vim.cmd.colorscheme("gotham256")
                vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
                vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            end
        end
    }
}
