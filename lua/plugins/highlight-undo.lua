return {
    {
        'tzachar/highlight-undo.nvim',
        -- lazy = false,
        event = "VeryLazy",
        config = function()
            require('highlight-undo').setup({
                hlgroup = 'HighlightUndo',
                duration = 300,
                keymaps = {
                    { 'n', 'u',     'undo', {} },
                    { 'n', '<C-r>', 'redo', {} },
                }
            })
        end
    },
}
