-- DAP = "debugging adapter protocol"
-- install dap via Mason


local nmap = function(keys, func, desc)
    if desc then
        desc = 'DAP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
end

nmap("<F6>", "<cmd>lua require'dap'.continue()<CR>", "Continue")
nmap("<F7>", "<cmd>lua require'dap'.step_over()<CR>", "Step Over")
nmap("<F8>", "<cmd>lua require'dap'.step_into()<CR>", "Step Into")
nmap("<F9>", "<cmd>lua require'dap'.step_out()<CR>", "Step Out")
nmap("<leader>b", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle [B]reakpoint")
-- nmap("<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
-- nmap("<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
-- nmap("<leader>ro", ":lua require'dap'.repl.open()<CR>")

require("nvim-dap-virtual-text").setup()
require("dapui").setup()

local dap, dapui = require("dap"), require("dapui")
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
    id = 'cppdbg',
    type = 'executable',
    command = '/home/nstefan002/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7'
}
dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
    },
    {
        name = 'Attach to gdbserver :1234',
        type = 'cppdbg',
        request = 'launch',
        MIMode = 'gdb',
        miDebuggerServerAddress = 'localhost:1234',
        miDebuggerPath = '/usr/bin/gdb',
        cwd = '${workspaceFolder}',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
    },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
