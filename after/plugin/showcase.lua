-- NOTE: see ~/.config/wezterm/wezterm.lua "user-var-changed"

if vim.g.showcase_cmd_loaded then
    return
end
vim.g.showcase_cmd_loaded = true

vim.api.nvim_create_user_command("Showcase", function(_)
    local wztrm = require("my_config.util.wezterm")
    if vim.g.showcase_mode_active then
        wztrm.change_font_size("-3")
        vim.cmd("Screenkey toggle")
        -- in case lsp-related plugins are not yet loaded
        pcall(vim.cmd, "LspStart")
        vim.g.showcase_mode_active = false
    else
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

vim.api.nvim_create_user_command("Screenshot", function(_)
    local wztrm = require("my_config.util.wezterm")
    if vim.g.screenshot_mode_active then
        wztrm.change_font_size("-5")

        -- unhide commandline
        vim.cmd("set cmdheight=1")

        -- unhide statusline
        vim.cmd("set laststatus=2")

        -- unhide tabline
        vim.cmd("set showtabline=1")

        -- delete tabpage
        vim.cmd("tabclose")

        vim.g.screenshot_mode_active = false
    else
        wztrm.change_font_size("+5")

        -- create new tabpage
        vim.cmd("tabnew")

        -- remove numbers and '~'
        vim.wo.number = false
        vim.wo.relativenumber = false
        vim.wo.fillchars = "eob: "

        -- hide commandline
        vim.cmd("set cmdheight=0")

        -- hide statusline
        vim.cmd("set laststatus=0")

        -- hide tabline
        vim.cmd("set showtabline=0")

        vim.g.screenshot_mode_active = true
    end
end, {
    nargs = "*",
    desc = "Prepare neovim for a screenshot",
})

vim.api.nvim_create_autocmd("VimLeave", {
    group = vim.api.nvim_create_augroup("showcase_vimleave", {}),
    callback = function()
        if vim.g.showcase_mode_active then
            vim.cmd("Showcase")
        elseif vim.g.screenshot_mode_active then
            vim.cmd("Screenshot")
        end
    end,
    desc = "Cleanup after showcase mode",
})
