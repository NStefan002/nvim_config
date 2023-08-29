return {
    -- color schemes
    {
        "ray-x/starry.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            local schemes_candidates = {
                "random",
                "dark_flat",
                "darcubox",
                "onedark",
                "tokyonight-night",
                "tokyonight-storm",
                "tokyonight-day",
                "tokyonight-moon",
                "solarized",
                "everblush",
                "one_monokai",
                "darcula-dark",
                "moonlight",
                "darksolar",
                "dracula",
                "dracula_blood",
                "darker",
                "emerald",
                "kanagawa",
                "light",
            }

            vim.keymap.set("n", "<leader>col", function()
                vim.ui.select(schemes_candidates, {
                    promt = "Select colorscheme",
                }, function(selected)
                    if not selected then
                        return
                    end
                    if selected == "random" then
                        -- do not select light theme
                        local random_scheme =
                            schemes_candidates[math.random(2, #schemes_candidates - 1)]
                        vim.cmd.colorscheme(random_scheme)
                        print(random_scheme)
                    elseif selected == "light" then
                        vim.cmd.colorscheme("balance")
                        vim.cmd("TransparentDisable")
                    else
                        vim.cmd.colorscheme(selected)
                        print(selected)
                    end
                end)
            end)
            vim.cmd.colorscheme("dracula")
        end,
    },
    { "cpea2506/one_monokai.nvim" },
    { "sekke276/dark_flat.nvim" },
    { "maxmx03/solarized.nvim", opts = { theme = "neo" } },
    { "rebelot/kanagawa.nvim" },
    { "navarasu/onedark.nvim", opts = { style = "deep", transparent = true } },
    { "dotsilas/darcubox-nvim" },
    { "folke/tokyonight.nvim" },
    {
        "Everblush/nvim",
        name = "everblush",
        opts = {
            transparent_background = true,
            nvim_tree = {
                contrast = false,
            },
        },
    },
    {
        "xiantang/darcula-dark.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    { "MetriC-DT/balance-theme.nvim" }, -- light colorscheme for presentation purposes
    {
        "xiyaowong/transparent.nvim",
        lazy = false,
        cond = function()
            return not vim.g.neovide
        end,
        config = function()
            require("transparent").setup({
                groups = { -- table: default groups
                    "Normal",
                    "NormalNC",
                    "Comment",
                    "Constant",
                    "Special",
                    "Identifier",
                    "Statement",
                    "PreProc",
                    "Type",
                    "Underlined",
                    "Todo",
                    "String",
                    "Function",
                    "Conditional",
                    "Repeat",
                    "Operator",
                    "Structure",
                    "LineNr",
                    "NonText",
                    "SignColumn",
                    "CursorLineNr",
                    "EndOfBuffer",
                },
                extra_groups = { "NormalFloat", "NvimTreeNormal" }, -- table: additional groups that should be cleared
                exclude_groups = {}, -- table: groups you don't want to clear
            })

            vim.cmd("TransparentEnable")
        end,
    },
}
