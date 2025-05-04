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
                },
                project = { enable = false },
                mru = { enable = false },
                footer = {},
            },
        })
    end,
}
