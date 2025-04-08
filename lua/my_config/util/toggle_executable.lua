local M = {}

function M.toggle()
    local file = vim.fn.expand("%:p")
    local short_file = vim.fn.expand("%:t")
    local is_executable = vim.fn.getfperm(file):find("x") ~= nil
    local notify = require("fidget").notify
    if is_executable then
        vim.system({ "chmod", "-x", file }, {}):wait()
        notify(("chmod -x %s"):format(short_file), vim.log.levels.INFO, { skip_history = true })
    else
        vim.system({ "chmod", "+x", file }, {}):wait()
        notify(("chmod +x %s"):format(short_file), vim.log.levels.INFO, { skip_history = true })
    end
end

return M
