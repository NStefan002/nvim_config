return {
    -- color schemes
    {
        'rafi/awesome-vim-colorschemes',
        lazy = false,
        priority = 1000,
        config = function()
            -- colorscheme on start
            vim.cmd.colorscheme("gotham256")
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end
    }
}
