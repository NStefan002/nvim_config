return {
    -- Git help
    {
        'tpope/vim-fugitive',
        lazy = true,
        config = function()
            vim.keymap.set("n", "<leader>ogs", vim.cmd.Git, { desc = "Fugitive: [O]pen [G]it [S]tatus" })
        end
    }
}
