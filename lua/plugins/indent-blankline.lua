return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VeryLazy",
    opts = {
        indent = {
            char = "│",
        },
        scope = {
            enabled = false,
        },
        exclude = { filetypes = { "help", "man", "dashboard", "notify", "checkhealth", "lspinfo" } },
    },
}
