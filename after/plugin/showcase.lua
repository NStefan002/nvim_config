-- NOTE: see ~/.config/wezterm/wezterm.lua "user-var-changed"

if vim.g.showcase_cmd_loaded then
    return
end
vim.g.showcase_cmd_loaded = true

---@class ShowcaseSubcmd
---@field impl fun(args:string[], data: table) The command implementation
---@field complete? fun(subcmd_arg_lead: string): string[] Command completions callback, taking the lead of the subcommand's arguments

---@type table<string, ShowcaseSubcmd>
local subcmds = {
    on = {
        impl = function(_, _)
            local wztrm = require("my_config.util.wezterm")
            wztrm.change_font_size("+3")
            vim.cmd("Screenkey toggle")
            vim.cmd("LspStop")
        end,
    },
    off = {
        impl = function(_, _)
            local wztrm = require("my_config.util.wezterm")
            wztrm.change_font_size("-3")
            vim.cmd("Screenkey toggle")
            vim.cmd("LspStart")
        end,
    },
}

vim.api.nvim_create_user_command("Showcase", function(data)
    if #data.fargs == 0 then
        vim.notify("Showcase: command expects exactly one argument", vim.log.levels.ERROR)
        return
    end
    local subcmd_key = data.fargs[1]
    local subcmd = subcmds[subcmd_key]
    if not subcmd then
        vim.notify("Showcase: unknown subcommand: " .. subcmd_key, vim.log.levels.ERROR)
        return
    end
    subcmd.impl(data.fargs, data)
end, {
    nargs = "*",
    complete = function(subcmd_arg_lead)
        local subcmd_keys = vim.tbl_keys(subcmds)
        return vim.iter(subcmd_keys)
            :filter(function(arg)
                return arg:find(subcmd_arg_lead) ~= nil
            end)
            :totable()
    end,
    desc = "Activate showcase mode",
})
