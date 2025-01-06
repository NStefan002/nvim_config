local api = vim.api

---@param radius integer
---@return integer
local function calc_donut_area(radius)
    local inner_radius = math.ceil(radius / 4)
    local outer_area = math.floor(math.pi * radius ^ 2)
    local inner_area = math.floor(math.pi * inner_radius ^ 2)
    return outer_area - inner_area
end

---@param text_len integer
---@return integer, integer
local function determine_radius(text_len)
    local best_outer_radius, best_inner_radius = 0, 0

    for outer_radius = 60, 7, -1 do
        local inner_radius = math.ceil(outer_radius / 4)
        local donut_area = calc_donut_area(outer_radius)

        if donut_area <= text_len then
            best_outer_radius, best_inner_radius = outer_radius, inner_radius
            break
        end
    end

    return best_outer_radius, best_inner_radius
end

---@param text string
---@param outer_radius integer
---@param inner_radius integer
---@return string[]
local function make_it_donut(text, outer_radius, inner_radius)
    local aspect_ratio = 0.5
    local height = math.ceil(outer_radius * 2 * aspect_ratio)
    local width = outer_radius * 2

    local center_x = math.floor(width / 2)
    local center_y = math.floor(height / 2)

    local donut = {}
    local text_idx = 1
    local text_len = api.nvim_strwidth(text)

    for y = 0, height - 1 do
        local row = {}
        for x = 0, width - 1 do
            local dx = x - center_x
            local dy = (y - center_y) / aspect_ratio
            local distance = math.sqrt(dx ^ 2 + dy ^ 2)

            if inner_radius <= distance and distance <= outer_radius then
                local next_char = text:sub(text_idx, text_idx)
                text_idx = text_idx + 1

                table.insert(row, next_char)

                if text_idx > text_len then
                    table.insert(donut, table.concat(row))
                    return donut
                end
            else
                table.insert(row, " ")
            end
        end
        table.insert(donut, table.concat(row))
    end

    return donut
end

local function cmd(data)
    local line_start, line_end
    if data.range == 0 then
        line_start, line_end = 0, -1
    else
        line_start, line_end = data.line1 - 1, data.line2
    end
    local lines = api.nvim_buf_get_lines(0, line_start, line_end, false)
    -- trim all lines
    lines = vim.iter(lines)
        :map(function(l)
            return vim.trim(l)
        end)
        :totable()
    local text = table.concat(lines, " ")
    local text_len = api.nvim_strwidth(text)

    local default_radius = 40
    local radius = math.floor(vim.bo.textwidth / 2)
    if radius == 0 then
        radius = math.floor(vim.bo.wrapmargin / 2)
    end
    if radius == 0 then
        radius = default_radius
    end

    local donuts = {}
    local default_donut_max_chars = calc_donut_area(default_radius)
    while text_len > default_donut_max_chars do
        table.insert(
            donuts,
            make_it_donut(text:sub(1, default_donut_max_chars), radius, math.ceil(radius / 4))
        )
        text = text:sub(default_donut_max_chars + 1)
        text_len = api.nvim_strwidth(text)
    end
    local outer_radius, inner_radius = determine_radius(text_len)
    table.insert(donuts, make_it_donut(text, outer_radius, inner_radius))

    local replacement = {}
    for _, donut in ipairs(donuts) do
        for _, row in ipairs(donut) do
            table.insert(replacement, row)
        end
        table.insert(replacement, "")
    end
    api.nvim_buf_set_lines(0, line_start, line_end, false, replacement)
end

api.nvim_create_user_command("Donutlify", cmd, {
    desc = "turn the buffer text into donuts",
    nargs = "*",
    range = true,
})
