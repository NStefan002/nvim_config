-- NOTE: this is only for a one file stuff, like when solving aoc, could be expanded

if not vim.fn.executable("ghcid") then
    return
end

local wezterm = require("my_config.util.wezterm")
local current_file = vim.api.nvim_buf_get_name(0)

if vim.g.ghcid_split_is_open and vim.g.ghcid_current_file == current_file then
    return
end

-- we changed files, so we need to run new ghcid
if vim.g.ghcid_split_is_open then
    wezterm.kill_pane(vim.g.ghcid_pane_id)
    vim.g.ghcid_split_is_open = false
end

local pane_id = wezterm.split_pane("right", true)
vim.g.ghcid_pane_id = pane_id
vim.g.ghcid_split_is_open = true
wezterm.spawn_command(
    ("ghcid --command 'stack ghci %s' --test ':main'"):format(current_file),
    pane_id
)
vim.g.ghcid_current_file = current_file
