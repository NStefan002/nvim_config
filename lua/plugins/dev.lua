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
            vim.keymap.set("n", "<C-q>", "<cmd>Speedtyper<CR>")
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
            timeout = 0,
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
        config = function()
            require("visual-surround").setup({
                enable_wrapped_deletion = true,
                exit_visual_mode = false,
            })
            vim.keymap.set("x", "ss", function()
                local opening = vim.fn.input("Opening: ")
                local closing = vim.fn.input("Closing: ")
                require("visual-surround").surround(opening, closing)
            end, { desc = "[visual-surround] Surround selection with custom string" })
        end,
    },
    {
        dev = true,
        "NStefan002/grammar.nvim",
        cmd = "Grammar",
        opts = {},
    },
    {
        "sphamba/smear-cursor.nvim",
        -- dev = true,
        -- enabled = function()
        --     return not vim.g.neovide
        -- end,
        -- event = "VimEnter",
        opts = {
            cursor_color = "#ff8800",
            stiffness = 0.6,
            trailing_stiffness = 0.1,
            trailing_exponent = 5,
            gamma = 1,
        },
    },
    {
        "NStefan002/donutlify.nvim",
        dev = true,
        lazy = false,
    },
    { dev = true, "JesperLundberg/svartafanan.nvim", event = "VeryLazy" },
}
