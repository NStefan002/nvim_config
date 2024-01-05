return {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
        local notify = require("notify")
        notify.setup({
            background_colour = "#000000",
            render = "default",
            stages = "slide",
            timeout = 7000,
        })
        -- use notify as a default way of showing notifications
        vim.notify = notify

        -- redirect print (lua func) to notify
        print = function(...)
            local print_safe_args = {}
            local _ = { ... }
            for i = 1, #_ do
                table.insert(print_safe_args, tostring(_[i]))
            end
            notify(table.concat(print_safe_args, " "), "info")
        end

        vim.keymap.set("n", "<leader>no", function()
            require("notify").dismiss({ silent = true })
        end, { desc = "Notify: Close All [No]tifications" })
    end,
}
