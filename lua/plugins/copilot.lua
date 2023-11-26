return {
    -- "github/copilot.vim",
    -- cmd = "Copilot",
    -- config = function()
    --     vim.keymap.set("i", "<C-a>", 'copilot#Accept("<CR>")', {
    --         expr = true,
    --         replace_keycodes = false,
    --     })
    --     vim.g.copilot_no_tab_map = true
    -- end,
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
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
