-- show z= in a nicer way

---@return string[]
local function get_results()
    local count = vim.v.count
    if count and count > 0 then
        return {}
    end

    local cursor_word = vim.fn.expand("<cword>")
    local bad = vim.fn.spellbadword(cursor_word)
    local word = bad[1] == "" and cursor_word or bad[1]

    return vim.fn.spellsuggest(word, 30, bad[2] == "caps")
end

return function()
    local results = get_results()
    if #results == 0 then
        vim.cmd("norm! " .. vim.v.count .. "z=")
        return
    end
    vim.ui.select(results, {
        promt = "Select colorscheme",
    }, function(item, idx)
        if not item then
            return
        end
        vim.cmd("norm! " .. idx .. "z=")
    end)
end
