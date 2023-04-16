return {
    -- navigation bar for tags
    {
        'preservim/tagbar',
        config = function()
            -- NOTE: install universal ctags from https://github.com/universal-ctags/ctags
            vim.keymap.set("n", "<F5>", "<cmd>TagbarToggle<CR>", { desc = "Toggle Tagbar" })
        end
    },
}
