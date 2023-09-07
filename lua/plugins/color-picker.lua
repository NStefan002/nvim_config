return {
    -- color picker
    "ziontee113/color-picker.nvim",
    keys = {
        {
            "<C-c>",
            "<cmd>PickColor<CR>",
            noremap = true,
            silent = true,
            desc = "color-picker: PickColor",
        },
    },
    opts = {
        ["icons"] = { "󰝤", "󰃉" },
        ["border"] = "rounded", -- none | single | double | rounded | solid | shadow
        ["background_highlight_group"] = "Normal",
        ["border_highlight_group"] = "FloatBorder",
        ["text_highlight_group"] = "Normal",
    },
}
