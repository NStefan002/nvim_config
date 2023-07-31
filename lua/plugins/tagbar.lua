return {
    -- navigation bar for tags
    -- NOTE: install universal ctags from https://github.com/universal-ctags/ctags
    'preservim/tagbar',
    keys = {
        { "<F5>", "<cmd>TagbarToggle<CR>", desc = "Toggle Tagbar" }
    }
}
