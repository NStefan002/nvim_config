return {
    {
        "echasnovski/mini.sessions",
        version = false,
        lazy = false,
        config = function()
            require("mini.sessions").setup({
                -- Hook functions for actions. Default `nil` means 'do nothing'.
                hooks = {
                    -- Before successful action
                    pre = { read = nil, write = nil, delete = nil },
                    -- After successful action
                    post = { read = nil, write = nil, delete = nil },
                },
                -- Whether to print session path after action
                verbose = { read = true, write = true, delete = true },
            })

            vim.keymap.set(
                "n",
                "<leader>ss",
                "<cmd>lua MiniSessions.select()<cr>",
                { desc = "Select a session to load" }
            )

            vim.keymap.set(
                "n",
                "<leader>sl",
                "<cmd>lua MiniSessions.read(MiniSessions.get_latest())<cr>",
                { desc = "Load the latest session" }
            )

            vim.keymap.set(
                "n",
                "<leader>sr",
                "<cmd>lua MiniSessions.select('delete')<cr>",
                { desc = "Select a session to remove" }
            )

            vim.keymap.set("n", "<leader>sw", function()
                vim.ui.input({
                    prompt = "Session name: ",
                }, function(input)
                    if not input then
                        return
                    end
                    local cmd
                    if input == "" then
                        cmd = "lua MiniSessions.write(MiniSessions.get_latest())"
                    else
                        cmd = ("lua MiniSessions.write('%s')"):format(input)
                    end
                    vim.cmd(cmd)
                end)
            end, {
                desc = "Write a session with given name (if name is empty then save the current session)",
            })
        end,
    },
}
