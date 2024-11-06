return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = "auto",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = {
                    statusline = {
                        "NvimTree",
                        "TelescopePrompt",
                        "dashboard",
                        "lspinfo",
                        "mason",
                        "checkhealth",
                        "help",
                        "man",
                        "toggleterm",
                        "lazy",
                    },
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = false,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = {
                    "filename",
                    "filesize",
                    function()
                        return require("screenkey").get_keys()
                    end,
                },
                lualine_x = { "filetype" },
                lualine_y = { "searchcount", "progress" },
                lualine_z = { "location" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {
                "quickfix",
                "aerial",
            },
        })

        vim.api.nvim_create_autocmd({ "BufEnter" }, {
            group = vim.api.nvim_create_augroup("LualineFlashFileName", {}),
            callback = function()
                if vim.g.lualine_c_hl_changed then
                    return
                end

                vim.g.lualine_c_hl_changed = true

                local orig_highlight =
                    vim.api.nvim_get_hl(0, { name = "lualine_c_normal", link = false })
                vim.api.nvim_set_hl(0, "lualine_c_normal", {
                    bg = "#ffcc00",
                    fg = "#000080",
                })
                vim.defer_fn(function()
                    vim.g.lualine_c_hl_changed = false
                    vim.api.nvim_set_hl(0, "lualine_c_normal", {
                        bg = orig_highlight.bg,
                        fg = orig_highlight.fg,
                    })
                end, 300)
            end,
            desc = "Flash filename on buffer change",
        })
    end,
}
