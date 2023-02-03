-- examples for your init.lua

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
-- require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
        adaptive_size = true,
        mappings = {
            list = {
                { key = "u", action = "dir_up" },
            },
        },
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
})


-- require("nvim-web-devicons").set_icon {
--     zsh = {
--         icon = "",
--         color = "#FFFF00",
--         cterm_color = "22",
--         name = "Zsh"
--     }
-- }
-- require'nvim-web-devicons'.setup {
--     -- your personnal icons can go here (to override)
--     -- you can specify color or cterm_color instead of specifying both of them
--     -- DevIcon will be appended to `name`
--     override = {
--         zsh = {
--             icon = "",
--             color = "#FFFF00",
--             cterm_color = "65",
--             name = "Zsh"
--         }
--     };
--     -- globally enable different highlight colors per icon (default to true)
--     -- if set to false all icons will have the default icon's color
--     color_icons = true;
--     -- globally enable default icons (default to false)
--     -- will get overriden by `get_icons` option
--     default = true;
-- }
