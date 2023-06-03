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
                timeout = 70000,
            })
            -- use notify as a default way of showing notifications
            vim.notify = notify
        end
    },
    {
        'mrded/nvim-lsp-notify',
        event = "VeryLazy",
        config = function()
            require("lsp-notify").setup({})
        end
    }
}
