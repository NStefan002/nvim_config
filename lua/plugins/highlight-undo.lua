return {
    "yuki-yano/highlight-undo.nvim",
    event = { "VeryLazy" },
    dependencies = { "vim-denops/denops.vim" },
    config = function()
        require('highlight-undo').setup({
            duration = 150
        })
    end,
}
