return {
    -- navigation bar for tags
    "stevearc/aerial.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        { "<F2>", "<cmd>AerialToggle right<CR>", desc = "Toggle Aerial" },
    },
    opts = {},
}
