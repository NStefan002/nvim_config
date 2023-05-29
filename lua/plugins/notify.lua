return {
    {
        'rcarriga/nvim-notify',
        lazy = false,
        priority = 500,
        config = function()
            local notify = require('notify')
            notify.setup({
                background_colour = '#000000',
                render = 'compact',
                stages = 'slide',
                timeout = 10000,
            })
            -- use notify as a default way of showing notifications
            vim.notify = notify
        end
    }
}
