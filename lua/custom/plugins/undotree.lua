return {
    -- undo history
    {
        'mbbill/undotree',
        lazy = false,
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle [U]ndooTree" })
        end
    },
}
