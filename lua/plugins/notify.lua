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

        -- NOTE: find a way to use this in the future
        -- local function notify_output(command, opts)
        --     local output = ""
        --     local notification
        --     local ntfy = function(msg, level)
        --         local notify_opts = vim.tbl_extend(
        --             "keep",
        --             opts or {},
        --             { title = table.concat(command, " "), replace = notification }
        --         )
        --         notification = vim.notify(msg, level, notify_opts)
        --     end
        --     local on_data = function(_, data)
        --         output = output .. table.concat(data, "\n")
        --         ntfy(output, "info")
        --     end
        --     vim.fn.jobstart(command, {
        --         on_stdout = on_data,
        --         on_stderr = on_data,
        --         on_exit = function(_, code)
        --             if #output == 0 then
        --                 ntfy("No output of command, exit code: " .. code, "warn")
        --             end
        --         end,
        --     })
        -- end
        --
        -- notify_output({ "echo", "hello world" })
    end,
}
