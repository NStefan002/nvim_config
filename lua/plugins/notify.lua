return {
    {
        'rcarriga/nvim-notify',
        event = "VeryLazy",
        config = function()
            local notify = require('notify')
            notify.setup({
                background_colour = '#000000',
                render = 'default',
                stages = 'slide',
                timeout = 7000,
            })
            -- use notify as a default way of showing notifications
            vim.notify = notify

            vim.api.nvim_create_autocmd({ "InsertEnter" }, {
                group = vim.api.nvim_create_augroup("NotifyClearGrp", {}),
                pattern = "*",
                callback = function()
                    require("notify").dismiss({ silent = true })
                end
            })
        end
    },
    {
        'mrded/nvim-lsp-notify',
        event = "VeryLazy",
        config = function()
            require("lsp-notify").setup({ silent = true })
        end
    }
}
