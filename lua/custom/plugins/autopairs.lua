return {
    -- auto close '"', ''', '{', '(', etc.
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup {}
        end
    },
}
