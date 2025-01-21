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

local surroundings = { i = "*", b = "**", a = "***" } -- italic, bold, bold&italic
local prefix = "s"
for k, v in pairs(surroundings) do
    vim.keymap.set("v", prefix .. k, function()
        require("visual-surround").surround(v, v)
    end, { buffer = true, desc = "[visual-surround] Surround selection with " .. v })
end
