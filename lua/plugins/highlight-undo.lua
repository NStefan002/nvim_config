return {
    {
        "tzachar/highlight-undo.nvim",
        keys = { { "u" }, { "<C-r>" } },
        opts = {
            duration = 300,
            keymaps = {
                paste = { disabled = true },
                Paste = { disabled = true },
            },
        },
    },
}
