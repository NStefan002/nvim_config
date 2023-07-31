return {
    -- undo history
    'mbbill/undotree',
    keys = {
        { "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle [U]ndoTree" }
    },
}
