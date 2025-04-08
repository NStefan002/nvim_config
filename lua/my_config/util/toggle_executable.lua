local M = {}

function M.toggle()
    local file = vim.fn.expand("%:p")
    local short_file = vim.fn.expand("%:t")
    local is_executable = vim.fn.getfperm(file):find("x") ~= nil
    -- check if the fidget plugin is loaded and if not use the default vim.notify
    local loaded, _ = pcall(require, "fidget")
    local notify = loaded and require("fidget").notify or vim.notify
    local opts = loaded and { skip_history = true } or {}
    if is_executable then
        vim.system({ "chmod", "-x", file }, {}):wait()
        notify(("chmod -x %s"):format(short_file), vim.log.levels.INFO, opts)
    else
        vim.system({ "chmod", "+x", file }, {}):wait()
        notify(("chmod +x %s"):format(short_file), vim.log.levels.INFO, opts)
    end
end

return M
