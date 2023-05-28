return {
    "yuki-yano/highlight-undo.nvim",
    event = { "BufEnter" },
    dependencies = { "vim-denops/denops.vim" },
    config = function()
        require('highlight-undo').setup({
            duration = 150
        })
    end,
}
