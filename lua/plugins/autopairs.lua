return {
    -- auto close '"', ''', '{', '(', etc.
    "windwp/nvim-autopairs",
    event = 'InsertEnter',
    opts = {
        check_ts = true,
        disable_filetype = { "TelescopePrompt" },
    }
}
