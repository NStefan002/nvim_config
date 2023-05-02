return {
    {
        'rcarriga/nvim-notify',
        config = function()
            local notify = require('notify')
            notify.setup({
                background_colour = '#000000',
                render = 'compact',
                stages = 'slide',
            })
            -- use notify as a default way of showing notifications
            vim.notify = notify
        end
    }
}
