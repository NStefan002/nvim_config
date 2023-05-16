return {
    -- Git help
    {
        'tpope/vim-fugitive',
        lazy = true,
        keys = {
            { "gst", vim.cmd.Git, desc = "Fugitive: Open [G]it [St]atus" }
        },
    }
}
