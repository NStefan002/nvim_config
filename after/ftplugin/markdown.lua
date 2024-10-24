vim.opt.wrap = false

local api = vim.api
local function toggle_checkbox()
    local line = api.nvim_get_current_line()
    if string.match(line, "%[%s%]") then
        local new_line, _ = line:gsub("%[%s%]", "[x]")
        api.nvim_set_current_line(new_line)
    elseif string.match(line, "%[x%]") then
        local new_line, _ = line:gsub("%[x%]", "[ ]")
        api.nvim_set_current_line(new_line)
    end
end
vim.keymap.set(
    "n",
    "<leader>tc",
    toggle_checkbox,
    { buffer = true, desc = "Toggle markdown checkboxes" }
)
