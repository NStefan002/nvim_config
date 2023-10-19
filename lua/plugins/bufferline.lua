return {
    "akinsho/bufferline.nvim",
    event = "BufEnter",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
        options = {
            mode = "buffers", -- set to "tabs" to only show tabpages instead
            indicator = {
                style = "underline", -- | 'icon' | 'none',
            },
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    text_align = "left", -- | 'center' | 'right'
                    separator = true,
                },
            },
            color_icons = true, -- whether or not to add the filetype icon highlights
            show_tab_indicators = true,
            separator_style = "slope", -- | "slant" | "thick" | "thin" | { 'any', 'any' },
        },
    },
}
