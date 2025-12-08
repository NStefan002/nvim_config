return {
    {
        "zbirenbaum/copilot.lua",
        -- event = "VeryLazy",
        config = function()
            require("copilot").setup({
                panel = {
                    enabled = false,
                },
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    debounce = 75,
                    keymap = {
                        accept = "<C-a>",
                        accept_word = false,
                        accept_line = false,
                        next = "<C-'>",
                        prev = '<C-">',
                        dismiss = "<C-x>",
                    },
                },
                filetypes = {
                    yaml = true,
                    markdown = true,
                    help = false,
                    gitcommit = true,
                    gitrebase = false,
                    hgcommit = false,
                    svn = false,
                    cvs = false,
                    ["."] = false,
                },
                copilot_node_command = "node", -- Node.js version must be > 18.x
                server_opts_overrides = {},
            })

            vim.keymap.set(
                "n",
                "<leader>ec",
                "<cmd>Copilot enable<CR>",
                { desc = "[E]nable [C]opilot" }
            )
            vim.keymap.set(
                "n",
                "<leader>dc",
                "<cmd>Copilot disable<CR>",
                { desc = "[D]isable [C]opilot" }
            )
            vim.cmd("Copilot enable")
        end,
    },
    {
        "olimorris/codecompanion.nvim",
        cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionCmd", "CodeCompanionActions" },
        config = true,
        dependencies = {
            { "nvim-lua/plenary.nvim", brach = "master" },
            "nvim-treesitter/nvim-treesitter",
        },
    },
    {
        "Exafunction/windsurf.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        event = "VeryLazy",
        config = function()
            require("codeium").setup({
                enable_cmp_source = false,
                virtual_text = {
                    enabled = true,
                    manual = false,
                    idle_delay = 50,
                    map_keys = true,
                    key_bindings = {
                        accept = "<c-a>",
                        accept_word = false,
                        accept_line = false,
                        clear = "<c-e>",
                        next = "<c-;>",
                        prev = "<c-'>",
                    },
                },
            })
        end,
    },
}
