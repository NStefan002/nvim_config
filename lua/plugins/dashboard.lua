return {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
    config = function()
        require("dashboard").setup({
            theme = "hyper",
            config = {
                header = {
                    "         ██████╗       ██████╗  █████╗ ███████╗███████╗        ",
                    "        ██╔═══██╗      ██╔══██╗██╔══██╗╚══███╔╝╚══███╔╝        ",
                    "        ██║   ██║█████╗██████╔╝███████║  ███╔╝   ███╔╝         ",
                    "        ██║▄▄ ██║╚════╝██╔══██╗██╔══██║ ███╔╝   ███╔╝          ",
                    "███████╗╚██████╔╝      ██║  ██║██║  ██║███████╗███████╗███████╗",
                    "╚══════╝ ╚══▀▀═╝       ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝",
                    "                                                       ",
                },
                week_header = {
                    enable = false,
                },
                shortcut = {
                    {
                        icon = " ",
                        icon_hl = "@property",
                        desc = "Update",
                        group = "@property",
                        action = "Lazy update",
                        key = "u",
                    },
                    {
                        icon = " ",
                        icon_hl = "@property",
                        desc = "Checkhealth",
                        group = "@property",
                        action = "checkhealth",
                        key = "c",
                    },
                    {
                        icon = "󰥔 ",
                        icon_hl = "@property",
                        desc = "Profile",
                        group = "@property",
                        action = "Lazy profile",
                        key = "p",
                    },
                    {
                        icon = " ",
                        icon_hl = "@property",
                        desc = "Sessions",
                        group = "@property",
                        action = "lua MiniSessions.select()",
                        key = "s",
                    },
                },
            },
        })

        -- remove '~' when dashboard is active
        vim.api.nvim_create_autocmd("VimEnter", {
            group = vim.api.nvim_create_augroup("DashboardNoTilde", {}),
            pattern = "*",
            callback = function()
                if vim.api.nvim_buf_get_name(0) == "" then
                    vim.opt_local.fillchars = { eob = " " }
                end
            end,
        })
    end,
}
