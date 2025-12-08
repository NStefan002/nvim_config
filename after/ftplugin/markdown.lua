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

vim.keymap.set(
    "n",
    "<leader>mt",
    "<cmd>Markview Toggle<cr>",
    { buffer = true, desc = "Toggle Markview" }
)

local surroundings = { i = "*", b = "**", a = "***" } -- italic, bold, bold&italic
local prefix = "s"
for k, v in pairs(surroundings) do
    vim.keymap.set("v", prefix .. k, function()
        require("visual-surround").surround(v, v)
    end, { buffer = true, desc = "[visual-surround] Surround selection with " .. v })
end

local function generate_toc()
    local toc = {}
    local lines = api.nvim_buf_get_lines(0, 0, -1, false)
    for _, line in ipairs(lines) do
        local level = string.match(line, "^#+")
        if level then
            local title = string.match(line, "^#+%s+(.+)")
            local link = string.gsub(title, "%s+", "-"):lower()
            table.insert(
                toc,
                string.rep("  ", #level - 1) .. "- [" .. title .. "](#" .. link .. ")"
            )
        end
    end
    local current_line = api.nvim_win_get_cursor(0)[1] - 1
    api.nvim_buf_set_lines(0, current_line, current_line, false, toc)
end

vim.keymap.set("n", "<leader>toc", function()
    generate_toc()
end, { buffer = true, desc = "Generate table of contents" })
