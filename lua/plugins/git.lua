return {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    keys = {
        {
            "<leader>G",
            "<cmd>Neogit<CR>",
            desc = "Open Neo[G]it",
        },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = true,
}
