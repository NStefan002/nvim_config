return {
    -- Git help
    {
        'tpope/vim-fugitive',
        lazy = true,
        keys = {
            { "gst", vim.cmd.Git, desc = "Fugitive: Open [G]it [St]atus" }
        },
    },
    {
        'lewis6991/gitsigns.nvim',
        event = { "BufReadPre" },
        config = function()
            require('gitsigns').setup()
        end
    }
}
