return {
    -- color schemes
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            local schemes_candidates = {
                "random",
                "default", -- for nightly default theme
                "light", -- for nightly default theme
                "tokyonight-night",
                "tokyonight-storm",
                "tokyonight-day",
                "tokyonight-moon",
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
                        vim.cmd("set background=light")
                        vim.cmd("TransparentDisable")
                    else
                        vim.cmd.colorscheme(selected)
                        print(selected)
                    end
                end)
            end)
            local version = vim.version()
            if version.minor <= 9 then
                vim.cmd.colorscheme("tokyonight-storm")
            end
        end,
    },
    {
        "xiyaowong/transparent.nvim",
        lazy = false,
        cond = function()
            local awesome_wm = false
            if vim.system ~= nil then
                local obj = vim.system({ "pgrep", "awesome" }, { text = true }):wait()
                awesome_wm = #obj.stdout > 0
            end
            return not vim.g.neovide and not awesome_wm
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
                -- NOTE: add "NormalFloat" to extra_groups if you stop using TSContext
                extra_groups = { "NvimTreeNormal", "FloatBorder" }, -- table: additional groups that should be cleared
                exclude_groups = { "TreesitterContext" }, -- table: groups you don't want to clear
            })

            vim.cmd("TransparentEnable")
        end,
    },
}
