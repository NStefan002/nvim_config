return {
    -- color schemes
    {
        "folke/tokyonight.nvim",
        lazy = false,
        config = function()
            local schemes_candidates = {
                "random",
                "default",
                "rose-pine",
                "tokyonight-night",
                "tokyonight-storm",
                "tokyonight-moon",
                "tokyonight-day",
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
                        -- do not select light themes
                        local random_scheme =
                            schemes_candidates[math.random(2, #schemes_candidates - 2)]
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
        end,
    },
    {
        "xiyaowong/transparent.nvim",
        lazy = false,
        config = function()
            require("transparent").setup({
                -- NOTE: add "NormalFloat" to extra_groups if you stop using TSContext
                extra_groups = { "NvimTreeNormal", "FloatBorder" }, -- table: additional groups that should be cleared
                exclude_groups = { "TreesitterContext" }, -- table: groups you don't want to clear
            })
            vim.cmd("TransparentEnable")
        end,
    },
    { "rose-pine/neovim", name = "rose-pine" },
}
