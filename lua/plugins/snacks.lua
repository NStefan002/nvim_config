return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    dependencies = { { "echasnovski/mini.icons", version = false } },
    config = function()
        local snacks = require("snacks")

        ---@type snacks.Config
        local opts = {
            styles = {
                lazygit = { border = "double", relative = "editor" },

                ["notification.history"] = {
                    border = "rounded",
                    relative = "editor",
                    minimal = true,
                    title = "Notification History",
                    title_pos = "right",
                    ft = "markdown",
                    bo = { filetype = "snacks_notif_history", modifiable = false },
                    wo = { winhighlight = "Normal:SnacksNotifierHistory", wrap = false },
                    keys = { q = "close", ["<c-c>"] = "close" },
                },
            },

            quickfile = { enabled = true },

            lazygit = { enabled = true },

            gitbrowse = { enabled = true },

            notifier = {
                enabled = true,
                timeout = 7000,
                margin = { top = 0, right = 1, bottom = 0 },
                padding = false,
                sort = { "level", "added" }, -- sort by level and time
                ---@type snacks.notifier.style
                style = "compact",
                refresh = 50, -- refresh at most every 50ms
            },

            statuscolumn = {
                enabled = true,
                left = { "sign" }, -- priority of signs on the left (high to low)
                right = { "fold", "git" }, -- priority of signs on the right (high to low)
                folds = {
                    open = true, -- show open fold icons
                    git_hl = false, -- use Git Signs hl for fold icons
                },
                git = {
                    -- patterns to match Git signs
                    patterns = { "GitSign", "MiniDiffSign" },
                },
                refresh = 50, -- refresh at most every 50ms
            },

            scratch = { enabled = true },

            indent = { enabled = true },

            terminal = {
                enabled = true,
                win = { style = "terminal", border = "single" },
            },

            image = { enabled = true },

            input = {
                enabled = true,
                icon = "",
            },

            dashboard = {
                enabled = true,
                width = 80,
                pane_gap = 5, -- empty columns between vertical panes
                preset = {
                    keys = {
                        {
                            icon = " ",
                            key = "c",
                            desc = "Checkhealth",
                            action = ":checkhealth",
                        },
                        {
                            icon = "󰥔 ",
                            key = "p",
                            desc = "Profile",
                            action = ":Lazy profile",
                            enabled = package.loaded.lazy ~= nil,
                        },
                        {
                            icon = "󰒲 ",
                            key = "u",
                            desc = "Update plugins",
                            action = ":Lazy update",
                            enabled = package.loaded.lazy ~= nil,
                        },
                    },
                    -- Used by the `header` section
                    header = [[
         ██████╗       ██████╗  █████╗ ███████╗███████╗
        ██╔═══██╗      ██╔══██╗██╔══██╗╚══███╔╝╚══███╔╝
        ██║   ██║█████╗██████╔╝███████║  ███╔╝   ███╔╝
        ██║▄▄ ██║╚════╝██╔══██╗██╔══██║ ███╔╝   ███╔╝
███████╗╚██████╔╝      ██║  ██║██║  ██║███████╗███████╗███████╗
╚══════╝ ╚══▀▀═╝       ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝]],
                },
                sections = {
                    { section = "header", align = "left" },
                    { section = "keys", gap = 1, padding = 1 },
                    {
                        pane = 2,
                        icon = " ",
                        desc = "Browse Repo",
                        padding = 1,
                        key = "b",
                        action = function()
                            snacks.gitbrowse()
                        end,
                    },
                    function()
                        local in_git = snacks.git.get_root() ~= nil
                        local cmds = {
                            -- {
                            --     title = "Notifications",
                            --     cmd = "gh notify -s -a -n5",
                            --     action = function()
                            --         vim.ui.open("https://github.com/notifications")
                            --     end,
                            --     key = "N",
                            --     icon = " ",
                            --     height = 5,
                            --     enabled = true,
                            -- },
                            {
                                title = "Open Issues",
                                cmd = "gh issue list -L 3",
                                key = "I",
                                action = function()
                                    vim.fn.jobstart("gh issue list --web", { detach = true })
                                end,
                                icon = " ",
                                height = 7,
                            },
                            {
                                icon = " ",
                                title = "Open PRs",
                                cmd = "gh pr list -L 3",
                                key = "P",
                                action = function()
                                    vim.fn.jobstart("gh pr list --web", { detach = true })
                                end,
                                height = 7,
                            },
                        }
                        return vim.tbl_map(function(cmd)
                            return vim.tbl_extend("force", {
                                pane = 2,
                                section = "terminal",
                                enabled = in_git,
                                padding = 1,
                                ttl = 5 * 60,
                                indent = 3,
                            }, cmd)
                        end, cmds)
                    end,
                    { section = "startup" },
                },
            },
        }

        snacks.setup(opts)

        -- notifier

        -- use snacks.notifier as a default way of showing notifications
        vim.notify = snacks.notifier.notify

        -- redirect print (lua func) to vim.notify
        -- and enhance it with vim.inspect
        print = function(...)
            local args = { ... }
            local output = {}
            for _, v in ipairs(args) do
                table.insert(output, vim.inspect(v))
            end
            vim.notify(table.concat(output, "\n\n"), vim.log.levels.INFO)
        end

        vim.keymap.set("n", "<leader>nh", function()
            snacks.notifier.show_history()
        end, { desc = "Get notification history" })

        vim.keymap.set("n", "<leader>no", function()
            snacks.notifier.hide()
        end, { desc = "Dismiss All Notifications" })

        -- lazygit

        vim.keymap.set("n", "<leader>gg", function()
            vim.cmd("tabnew")
            snacks.lazygit()
        end, { desc = "Lazygit" })

        -- gitbrowse

        vim.keymap.set({ "n", "v" }, "<leader>gb", function()
            snacks.gitbrowse()
        end, { desc = "Git Browse" })

        -- scratch

        vim.keymap.set("n", "<leader>.", function()
            snacks.scratch()
        end, { desc = "Toggle Scratch Buffer" })
        vim.keymap.set("n", "<leader>S", function()
            snacks.scratch.select()
        end, { desc = "Select Scratch Buffer" })

        -- terminal

        vim.keymap.set("n", "<leader>T", function()
            snacks.terminal.toggle("zsh")
        end, { desc = "Toggle floating terminal" })
        vim.keymap.set("n", "<leader>run", function()
            local frequently_used_tools = {
                "bluetui",
                "gh dash",
                "htop",
                "lazydocker",
                "lazygit",
                "wrkflw",
            }
            vim.ui.select(frequently_used_tools, {
                prompt = "Select a tool to run in the floating terminal: ",
            }, function(item)
                if not item then
                    return
                end
                vim.cmd("tabnew")
                snacks.terminal.open(item)
            end)
        end, {
            desc = "Select and run one of the frequently used tools in the floating terminal",
        })
    end,
}
