return {
    -- debugger support
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            { "igorlfs/nvim-dap-view", opts = {} },
        },
        keys = {
            "<leader>B",
            "<F5>",
            "<F6>",
            "<F7>",
            "<F8>",
            "<leader>ro",
        },
        config = function()
            local nmap = function(keys, func, desc)
                if desc then
                    desc = "DAP: " .. desc
                end

                vim.keymap.set("n", keys, func, { desc = desc })
            end

            nmap(
                "<leader>B",
                "<cmd>lua require'dap'.toggle_breakpoint()<CR>",
                "Toggle [B]reakpoint"
            )
            nmap("<F5>", "<cmd>lua require'dap'.continue()<CR>", "Continue")
            nmap("<F6>", "<cmd>lua require'dap'.step_into()<CR>", "Step Into")
            nmap("<F7>", "<cmd>lua require'dap'.step_over()<CR>", "Step Over")
            nmap("<F8>", "<cmd>lua require'dap'.step_out()<CR>", "Step Out")
            -- nmap("<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
            -- nmap("<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
            nmap("<leader>ro", ":lua require'dap'.repl.open()<CR>")

            require("nvim-dap-virtual-text").setup({})

            local dap, dapui = require("dap"), require("dap-view")
            -- local dap, dapui = require("dap"), require("dapui")
            -- dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            dap.adapters.cppdbg = {
                id = "cppdbg",
                type = "executable",
                command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
            }

            local function get_args()
                local input = vim.fn.input("Enter command line arguments: ")
                if input ~= "" then
                    return vim.split(input, "%s+", { plain = false, trimempty = true })
                else
                    return nil
                end
            end

            -- don't forget to add debug flag (e.g. -g for g++/gcc)
            dap.configurations.cpp = {
                {
                    name = "default",
                    type = "cppdbg",
                    request = "launch",
                    program = "a.out",
                    cwd = "${workspaceFolder}",
                    stopAtEntry = true,
                    args = get_args,
                },
                {
                    name = "custom",
                    type = "cppdbg",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopAtEntry = true,
                    args = get_args,
                },
                {
                    name = "Attach to gdbserver :1234",
                    type = "cppdbg",
                    request = "launch",
                    MIMode = "gdb",
                    miDebuggerServerAddress = "localhost:1234",
                    miDebuggerPath = "/usr/bin/gdb",
                    cwd = "${workspaceFolder}",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    args = get_args,
                },
            }
            dap.configurations.c = dap.configurations.cpp
            dap.configurations.rust = dap.configurations.cpp

            -- For debugging Neovim's source code
            local home = vim.uv.os_homedir()
            table.insert(
                dap.configurations.c,
                setmetatable({
                    name = "Neovim",
                    type = "cppdbg",
                    request = "launch",
                    program = home .. "/repos/neovim/build/bin/nvim",
                    cwd = "${workspaceFolder}",
                    stopAtEntry = true,
                    args = get_args,
                    externalConsole = true,
                }, {
                    __call = function(config)
                        -- Listeners are indexed by a key.
                        -- This is like a namespace and must not conflict with what plugins
                        -- like nvim-dap-ui or nvim-dap itself uses.
                        -- It's best to not use anything starting with `dap`
                        local key = "neovim-debug-auto-attach"

                        -- dap.listeners.<before | after>.<event_or_command>.<plugin_key>`
                        -- We listen to the `initialize` response. It indicates a new session got initialized
                        dap.listeners.after.initialize[key] = function(session)
                            -- Immediately clear the listener, we don't want to run this logic for additional sessions
                            dap.listeners.after.initialize[key] = nil

                            -- The first argument to a event or response is always the session
                            -- A session contains a `on_close` table that allows us to register functions
                            -- that get called when the session closes.
                            -- We use this to ensure the listeners get cleaned up
                            session.on_close[key] = function()
                                for _, handler in pairs(dap.listeners.after) do
                                    handler[key] = nil
                                end
                            end
                        end

                        -- We listen to `event_process` to get the pid:
                        dap.listeners.after.event_process[key] = function(_, body)
                            -- Immediately clear the listener, we don't want to run this logic for additional sessions
                            dap.listeners.after.event_process[key] = nil

                            local ppid = body.systemProcessId
                            -- The pid is the parent pid, we need to attach to the child. This uses the `ps` tool to get it
                            -- It takes a bit for the child to arrive. This uses the `vim.wait` function to wait up to a second
                            -- to get the child pid.
                            vim.wait(1000, function()
                                return tonumber(
                                    vim.fn.system("ps -o pid= --ppid " .. tostring(ppid))
                                ) ~= nil
                            end)
                            local pid =
                                tonumber(vim.fn.system("ps -o pid= --ppid " .. tostring(ppid)))

                            -- If we found it, spawn another debug session that attaches to the pid.
                            if pid then
                                dap.run({
                                    name = "Neovim embedded",
                                    type = "cppdbg",
                                    request = "attach",
                                    pid = pid,
                                    program = home .. "/repos/neovim/build/bin/nvim",
                                    env = {
                                        "VIMRUNTIME=" .. home .. "/repos/neovim/runtime",
                                    },
                                    cwd = home .. "/repos/neovim/",
                                    externalConsole = false,
                                })
                            end
                        end
                        return config
                    end,
                })
            )

            -- icons
            local dap_breakpoint = {
                error = {
                    text = "",
                },
                rejected = {
                    text = "",
                },
                stopped = {
                    text = "",
                    texthl = "LspDiagnosticsSignInformation",
                    linehl = "DiagnosticUnderlineInfo",
                    numhl = "LspDiagnosticsSignInformation",
                },
            }

            vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
            vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
            vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)

            dap.defaults.fallback.external_terminal = {
                command = "/usr/bin/wezterm",
                args = { "-e" },
            }
        end,
    },

    -- { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
    { "theHamsta/nvim-dap-virtual-text" },
    {
        "mfussenegger/nvim-dap-python",
        ft = { "python" },
        dependencies = "mfussenegger/nvim-dap",
        config = function()
            -- uses the debugypy installation by mason
            local debugpyPythonPath = require("mason-registry")
                .get_package("debugpy")
                :get_install_path() .. "/venv/bin/python3"
            require("dap-python").setup(debugpyPythonPath, {})
        end,
    },
}
