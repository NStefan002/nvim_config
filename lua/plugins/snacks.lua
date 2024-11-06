return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    dependencies = { { "echasnovski/mini.icons", version = false } },
    config = function()
        ---@module "snacks"
        ---@type snacks.Config
        local opts = {
            styles = {},
            bigfile = { enabled = false },
            notifier = { enabled = false },
            quickfile = { enabled = true },
            statuscolumn = {
                left = { "sign", "mark" }, -- priority of signs on the left (high to low)
                right = { "fold", "git" }, -- priority of signs on the right (high to low)
                folds = {
                    open = true, -- show open fold icons
                    git_hl = false, -- use Git Signs hl for fold icons
                },
                git = {
                    -- patterns to match Git signs
                    patterns = { "GitSign", "MiniDiffSign" },
                },
                refresh = 50, -- refresh at most every 50ms
            },
            words = { enabled = false },
        }

        local snacks = require("snacks")
        snacks.setup(opts)

        -- vim.keymap.set("n", "<leader>no", function()
        --     snacks.notifier.hide()
        -- end, {
        --     desc = "Dismiss All Notifications",
        -- })

        vim.keymap.set("n", "<leader>gg", function()
            snacks.lazygit()
        end, {
            desc = "Lazygit",
        })

        vim.keymap.set("n", "<leader>gB", function()
            snacks.gitbrowse()
        end, {
            desc = "Git Browse",
        })
    end,
}
