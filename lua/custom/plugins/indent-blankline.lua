return {
    {
        "lukas-reineke/indent-blankline.nvim",
        lazy = false,
        config = function()
            require("indent_blankline").setup({
                -- fix issue with dashboard
                filetype_exclude = { 'help', 'man', 'dashboard', 'notify', 'checkhealth', 'lspinfo' }
            })
        end
    },
}
