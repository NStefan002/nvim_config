-- NOTE: see ~/.config/wezterm/wezterm.lua "user-var-changed"

if vim.g.showcase_cmd_loaded then
    return
end
vim.g.showcase_cmd_loaded = true

vim.api.nvim_create_user_command("Showcase", function(_)
    if vim.g.showcase_mode_active then
        local wztrm = require("my_config.util.wezterm")
        wztrm.change_font_size("-3")
        vim.cmd("Screenkey toggle")
        -- in case lsp-related plugins are not yet loaded
        pcall(vim.cmd, "LspStart")
        vim.g.showcase_mode_active = false
    else
        local wztrm = require("my_config.util.wezterm")
        wztrm.change_font_size("+3")
        vim.cmd("Screenkey toggle")
        -- in case lsp-related plugins are not yet loaded
        pcall(vim.cmd, "LspStart")
        vim.g.showcase_mode_active = true
    end
end, {
    nargs = "*",
    desc = "Toggle showcase mode",
})
