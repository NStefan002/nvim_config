return {
    -- TODO: find more Neovim-specific colorschemes (because of some hlgroups e.g. the one for inlay hints)
    -- then remove the hlgroups linking in lsp.lua file
    -- color schemes
    {
        'rafi/awesome-vim-colorschemes',
        lazy = false,
        priority = 1000,
        config = function()
            -- colorschemes on startup
            if vim.g.neovide then
                -- colorscheme for neovide
                vim.cmd.colorscheme("one_monokai")
            else
                vim.cmd.colorscheme("gotham256")
            end

            local schemes_candidates = {
                "random",
                "dark_flat",
                "solarized",
                "one_monokai",
                "molokai",
                "everblush",
                "gotham256",
                "gruvbox",
                "ayu",
                "hybrid_reverse",
                "onedark",
                "carbonized-dark",
                "deus",
                "flattened_dark",
                "focuspoint",
                "lucid",
                "yellow-moon",
                "PaperColor",
                "habamax",
                "light"
            }

            vim.keymap.set("n", "<leader>col", function()
                vim.ui.select(schemes_candidates, {
                    promt = "Select colorscheme",
                    telescope = require("telescope.themes").get_dropdown()
                }, function(selected)
                    if not selected then
                        return
                    end
                    if selected == "random" then
                        -- do not select light theme
                        local random_scheme = schemes_candidates[math.random(2, #schemes_candidates - 1)]
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
        end
    },
    { 'cpea2506/one_monokai.nvim' },
    { 'sekke276/dark_flat.nvim' },
    { 'maxmx03/solarized.nvim',   opts = { theme = 'neo' } },
    {
        'Everblush/nvim',
        name = 'everblush',
        opts = {
            transparent_background = true,
            nvim_tree = {
                contrast = false,
            },
        }
    },
    { 'MetriC-DT/balance-theme.nvim' }, -- light colorscheme for presentation purposes
    {
        "xiyaowong/transparent.nvim",
        lazy = false,
        cond = function()
            return not vim.g.neovide
        end,
        config = function()
            require("transparent").setup({
                groups = { -- table: default groups
                    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
                    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
                    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
                    'SignColumn', 'CursorLineNr', 'EndOfBuffer',
                },
                extra_groups = { 'NormalFloat', 'NvimTreeNormal' }, -- table: additional groups that should be cleared
                exclude_groups = {},                                -- table: groups you don't want to clear
            })

            vim.cmd('TransparentEnable')
        end
    },
}
