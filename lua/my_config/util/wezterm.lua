---@alias wezterm.direction "top" | "bottom" | "left" | "right"

---@param direction wezterm.direction
---@return wezterm.direction
local function opposite_direction(direction)
    local opposites = {
        top = "bottom",
        bottom = "top",
        left = "right",
        right = "left",
    }
    return opposites[direction]
end

local M = {}

---@param direction wezterm.direction
---@param stay_in_current_pane? boolean
---@return string
function M.split_pane(direction, stay_in_current_pane)
    local obj = vim.system(
        { "wezterm", "cli", "split-pane", ("--%s"):format(direction), "--percent", "25" },
        { text = true }
    ):wait()
    if stay_in_current_pane then
        M.focus_pane(opposite_direction(direction))
    end
    return (obj.stdout:gsub("^%s*(.-)%s*$", "%1"))
end

---@param id string
function M.kill_pane(id)
    vim.system({ "wezterm", "cli", "kill-pane", ("--pane-id=%s"):format(id) }, { text = true })
end

---@param direction wezterm.direction
function M.focus_pane(direction)
    vim.system({ "wezterm", "cli", "activate-pane-direction", direction }, { text = true })
end

---@param command string
---@param pane_id string
function M.spawn_command(command, pane_id)
    local enter = "\n"
    vim.system({
        "wezterm",
        "cli",
        "send-text",
        ("--pane-id=%s"):format(pane_id),
        "--no-paste",
        command .. enter,
    }, { text = true })
end

---@param delta string
function M.change_font_size(delta)
    local stdout = vim.uv.new_tty(1, false)
    if not stdout then
        return
    end
    stdout:write(
        ("\x1b]1337;SetUserVar=%s=%s\b"):format(
            "WEZTERM_FONT_SIZE",
            vim.fn.system({ "base64" }, tostring(delta))
        )
    )
    vim.cmd([[redraw]])
end

return M
