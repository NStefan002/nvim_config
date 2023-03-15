vim.keymap.set("n", "<C-c>", "<cmd>PickColor<CR>", { noremap = true, silent = true, desc = "PickColor" })
vim.keymap.set("i", "<C-c>", "<cmd>PickColorInsert<CR>", { noremap = true, silent = true, desc = "PickColorInsert" })

-- vim.keymap.set("n", "your_keymap", "<cmd>ConvertHEXandRGB<cr>", opts)
-- vim.keymap.set("n", "your_keymap", "<cmd>ConvertHEXandHSL<cr>", opts)

require("color-picker").setup({
    ["icons"] = { "ﱢ", "" },
    ["border"] = "rounded", -- none | single | double | rounded | solid | shadow
    -- ["keymap"] = {          -- mapping example:
    --     ["U"] = "<Plug>ColorPickerSlider5Decrease",
    --     ["O"] = "<Plug>ColorPickerSlider5Increase",
    -- },
    ["background_highlight_group"] = "Normal",
    ["border_highlight_group"] = "FloatBorder",
    ["text_highlight_group"] = "Normal",
})

vim.cmd([[hi FloatBorder guibg=NONE]]) -- if you don't want weird border background colors around the popup.
