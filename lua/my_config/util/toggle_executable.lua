local M = {}

function M.toggle()
    local file = vim.fn.expand("%:p")
    local short_file = vim.fn.expand("%:t")
    local is_executable = vim.fn.getfperm(file):find("x") ~= nil
    -- check if the fidget plugin is loaded and if not use the default vim.notify
    if is_executable then
        vim.system({ "chmod", "-x", file }, {}):wait()
        vim.api.nvim_echo({
            { "chmod", "" },
            { " -x ", "DiagnosticVirtualTextError" },
            { short_file, "Directory" },
        }, false, { verbose = false })
    else
        vim.system({ "chmod", "+x", file }, {}):wait()
        vim.api.nvim_echo({
            { "chmod", "" },
            { " +x ", "DiagnosticVirtualTextOk" },
            { short_file, "Directory" },
        }, false, { verbose = false })
    end
end

return M
