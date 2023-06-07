return {
    "yuki-yano/highlight-undo.nvim",
    lazy = false,
    cond = function()
        if vim.g.neovide then
            return false
        end
        return true
    end,
    dependencies = { "vim-denops/denops.vim" },
    config = function()
        require('highlight-undo').setup({
            duration = 150
        })
    end,
}
