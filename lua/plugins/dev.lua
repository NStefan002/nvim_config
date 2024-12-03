return {
    { dev = true, "NStefan002/busted-wrapper.nvim", lazy = false, opts = {} },
    {
        dev = true,
        "NStefan002/wormhole.nvim",
        lazy = false,
        config = function()
            vim.keymap.set(
                "n",
                "<c-s-i>",
                "<Plug>(WormholeLabelsToggle)",
                { desc = "Wormhole Labels Toggle" }
            )
        end,
    },
    {
        dev = true,
        "NStefan002/speedtyper.nvim",
        lazy = false,
        config = function()
            vim.keymap.set("n", "<C-q>", "<cmd>SpeedTyper<CR>")
        end,
    },
    { dev = true, "NStefan002/2048.nvim", cmd = "Play2048", config = true },
    {
        dev = true,
        "NStefan002/15puzzle.nvim",
        cmd = "Play15puzzle",
        config = true,
    },
    {
        dev = true,
        "NStefan002/donut.nvim",
        opts = {
            timeout = 20 * 60,
        },
        lazy = false,
    },
    {
        dev = true,
        "letieu/hacker.nvim",
        cmd = { "Hack", "HackAuto", "HackFollow", "HackFollowAuto" },
        config = true,
    },
    {
        dev = true,
        "NStefan002/screenkey.nvim",
        lazy = false,
        version = "*",
        ---@module "screenkey"
        ---@type screenkey.config
        opts = {
            group_mappings = true,
            disable = {
                buftypes = { "terminal" },
            },
        },
    },
    {
        dev = true,
        "NStefan002/visual-surround.nvim",
        event = "VeryLazy",
        config = true,
    },
    {
        dev = true,
        "NStefan002/grammar.nvim",
        cmd = "Grammar",
        opts = {},
    },
}
