local M = {}

---generates tab label and its highlight group and enables it to be clickable
---@param tab_id integer
---@param tab_label string
---@return string
local function generate_tab_label(tab_id, tab_label)
    local is_current = tab_id == vim.api.nvim_get_current_tabpage()
    -- select the highlight group
    local tab_name = is_current and "%#TabLineSel#" or "%#TabLine#"
    -- <tab_id>%T combination allows left click to switch to <tab_id> tab
    tab_name = ("%s%%%dT%s"):format(tab_name, tab_id, tab_label)
    return tab_name
end

---custom tabline
---@return string
function M.tabline()
    -- `nvim_list_tabpages` returns a list of tab IDs in order they appear visually
    local tab_ids = vim.api.nvim_list_tabpages()
    local current_file = vim.fn.expand("%:t")
    local current_filetype = vim.bo.filetype
    current_file = (current_file == "" and current_filetype ~= "") and current_filetype
        or current_file
    current_file = current_file == "" and " [No Name] " or (" %s "):format(current_file)
    local tabline = ""
    if #tab_ids > 1 then
        -- draw tabline with these elements:
        -- [ tabs ] [ fill ] [ current file ] [ fill ] [ close ]
        for idx, tab_id in ipairs(tab_ids) do
            tabline = ("%s%s"):format(tabline, generate_tab_label(tab_id, (" %d "):format(idx)))
        end
        -- %= splits the text into two parts, the part before %= is left aligned and the part after %= is right aligned,
        -- we can use this to try to center some text
        tabline = ("%s%%#TabLineFill#%%T"):format(tabline)
        tabline = ("%s%%=%%#TabLine#%s"):format(tabline, current_file)
        tabline = ("%s%%#TabLineFill#%%T"):format(tabline)
        -- %999X sequence allows left click on the close button to close the current tab
        tabline = ("%s%%=%%#TabLine#%%999X  "):format(tabline)
    else
        tabline = "%#TabLineFill#%T"
        tabline = ("%s%%=%%#TabLine#%s%%#TabLineFill#%%=%%T"):format(tabline, current_file)
    end
    return tabline
end

---sets highlight groups for tabline
function M.set_hl_groups()
    local hl = vim.api.nvim_set_hl
    hl(0, "TabLine", { link = "Pmenu" })
    hl(0, "TabLineFill", { link = "StatusLineNC" })
    hl(0, "TabLineSel", { link = "Visual" })
end

return M
