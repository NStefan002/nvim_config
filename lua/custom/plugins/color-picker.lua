return {
    -- color picker (similar to VSC)
    {
        "ziontee113/color-picker.nvim",
        lazy = true,
        config = function()
            vim.keymap.set("n", "<C-c>", "<cmd>PickColor<CR>", { noremap = true, silent = true, desc = "PickColor" })
            vim.keymap.set("i", "<C-c>", "<cmd>PickColorInsert<CR>",
                { noremap = true, silent = true, desc = "PickColorInsert" })

            require("color-picker").setup({
                ["icons"] = { "ﱢ", "" },
                ["border"] = "rounded", -- none | single | double | rounded | solid | shadow
                ["background_highlight_group"] = "Normal",
                ["border_highlight_group"] = "FloatBorder",
                ["text_highlight_group"] = "Normal",
            })

            vim.cmd([[hi FloatBorder guibg=NONE]]) -- if you don't want weird border background colors around the popup.
        end
    }
}
