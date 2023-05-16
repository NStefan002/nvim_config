return {
    -- winbar (like in VSC)
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        event = { 'BufEnter' },
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        config = function()
            require("barbecue").setup({
                attach_navic = true,
                create_autocmd = false,
                include_buftypes = { "" },
                exclude_filetypes = { "netrw", "toggleterm", "nvim-tree" },
                modifiers = {
                    dirname = ":~:.",
                    basename = "",
                },
                show_dirname = true,
                show_basename = true,
                show_modified = false,
                modified = function(bufnr) return vim.bo[bufnr].modified end,
                show_navic = true,
                lead_custom_section = function() return " " end,
                custom_section = function() return " " end,
                theme = "auto",
                context_follow_icon_color = false,
                symbols = {
                    modified = "●",
                    ellipsis = "…",
                    separator = "",
                },
                kinds = {
                    File = "",
                    Module = "",
                    Namespace = "",
                    Package = "",
                    Class = "",
                    Method = "",
                    Property = "",
                    Field = "",
                    Constructor = "",
                    Enum = "",
                    Interface = "",
                    Function = "",
                    Variable = "",
                    Constant = "",
                    String = "",
                    Number = "",
                    Boolean = "",
                    Array = "",
                    Object = "",
                    Key = "",
                    Null = "",
                    EnumMember = "",
                    Struct = "",
                    Event = "",
                    Operator = "",
                    TypeParameter = "",
                },
            })

            -- faster and smoother refresh
            vim.api.nvim_create_autocmd({
                "WinResized",
                "BufWinEnter",
                "CursorHold",
                "InsertLeave",

                -- include this if you have set `show_modified` to `true`
                -- "BufModifiedSet",
            }, {
                group = vim.api.nvim_create_augroup("barbecue.updater", {}),
                callback = function()
                    require("barbecue.ui").update()
                end,
            })

            -- show barbecue globally
            require("barbecue.ui").toggle(true)
        end
    }
}
