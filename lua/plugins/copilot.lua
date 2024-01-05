return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    keys = {
        {
            "<leader>ec",
            "<cmd>Copilot enable<CR>",
            desc = "[E]nable [C]opilot",
        },
        {
            "<leader>dc",
            "<cmd>Copilot disable<CR>",
            desc = "[D]isable [C]opilot",
        },
    },
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
                yaml = false,
                markdown = false,
                help = false,
                gitcommit = false,
                gitrebase = false,
                hgcommit = false,
                svn = false,
                cvs = false,
                ["."] = false,
            },
            copilot_node_command = "node", -- Node.js version must be > 18.x
            server_opts_overrides = {},
        })
    end,
}
