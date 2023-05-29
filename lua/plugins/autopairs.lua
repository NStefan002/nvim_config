return {
    -- auto close '"', ''', '{', '(', etc.
    {
        "windwp/nvim-autopairs",
        event = { 'InsertEnter' },
        config = function()
            require("nvim-autopairs").setup {
                check_ts = true,
                disable_filetype = { "TelescopePrompt" },
            }
        end
    },
}