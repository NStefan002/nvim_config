return {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
        require('dashboard').setup {
            theme = 'hyper',
            config = {
                header = {
                    -- ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
                    -- ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
                    -- ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
                    -- ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
                    -- ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
                    -- ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
                    [[                                                                       ]],
                    [[  ██████   █████                   █████   █████  ███                  ]],
                    [[ ░░██████ ░░███                   ░░███   ░░███  ░░░                   ]],
                    [[  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████   ]],
                    [[  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███  ]],
                    [[  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███  ]],
                    [[  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███  ]],
                    [[  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████ ]],
                    [[ ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░  ]],
                    [[                                                                       ]],
                },
                week_header = {
                    enable = false,
                },
                shortcut = {
                    { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
                    {
                        icon = '󱑃 ',
                        icon_hl = '@property',
                        desc = 'Profile',
                        group = 'Label',
                        action = 'Lazy profile',
                        key = 'p',
                    },
                    {
                        icon = ' ',
                        icon_hl = '@variable',
                        desc = 'Files',
                        group = 'Label',
                        action = 'Telescope find_files',
                        key = 'f',
                    },
                    {
                        icon = '󰅳 ',
                        icon_hl = '@variable',
                        desc = 'String',
                        group = 'Label',
                        action = 'Telescope live_grep',
                        key = 's',
                    },
                },
            },
        }

        -- remove when dashboard is active
        vim.api.nvim_create_autocmd("VimEnter", {
            group = vim.api.nvim_create_augroup("DashboardNoTilde", {}),
            pattern = "*",
            callback = function()
                if vim.api.nvim_buf_get_name(0) == '' then
                    vim.opt_local.fillchars = { eob = ' ' }
                end
            end
        })
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
}
