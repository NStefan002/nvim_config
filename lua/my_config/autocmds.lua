local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local aucmdsStarterPack = augroup("aucmdsStarterPack", { clear = true })

autocmd("TextYankPost", {
    group = aucmdsStarterPack,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
    desc = "highlight yanked text",
})

autocmd("BufWritePre", {
    group = aucmdsStarterPack,
    pattern = "*",
    command = [[%s/\s\+$//e]],
    desc = "remove trailing spaces",
})

autocmd("FileType", {
    group = aucmdsStarterPack,
    pattern = {
        "help",
        "vim", -- for opening commands history on accident with q:
        "man",
        "checkhealth",
        "notify",
        "fugitive",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
    end,
    desc = "exit certain files with just 'q'",
})

autocmd("ColorScheme", {
    group = aucmdsStarterPack,
    pattern = "*",
    callback = function()
        local hl = vim.api.nvim_set_hl
        hl(0, "Search", { link = "IncSearch" })
        hl(0, "CurSearch", { undercurl = true, italic = true, fg = "lime" })
        hl(0, "FoldColumn", {})
    end,
    desc = "Update hlgroups for / and ?, fix some highlights",
})

autocmd("BufEnter", {
    group = augroup("CommentFixGrp", { clear = true }),
    pattern = "*",
    callback = function()
        vim.opt.formatoptions:remove({ "c", "r", "o" })
    end,
    desc = "Fix auto-commenting new line when entering insert mode e.g. with 'o'",
})

-- autocmd({ "BufRead", "BufNewFile" }, {
--     group = aucmdsStarterPack,
--     pattern = {
--         '*.txt',
--         '*.md'
--     },
--     callback = function()
--         vim.opt.spell = true
--         vim.opt.spelllang = 'en'
--     end,
--     desc = "enable spellcheck for certain files"
-- })

-- use this instead of lukas-reineke/indent-blankline.nvim
local function update_lead()
    local lead = "╎"
    for i = 1, vim.bo.tabstop - 1 do
        lead = lead .. " "
    end
    vim.opt.listchars = { leadmultispace = lead, multispace = lead }
end

vim.api.nvim_create_autocmd("OptionSet", {
    pattern = { "listchars", "tabstop", "filetype" },
    callback = update_lead,
})

vim.api.nvim_create_autocmd("BufReadPre", { callback = update_lead })

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "NvimTree",
        "dashboard",
        "lspinfo",
        "mason",
        "checkhealth",
        "help",
        "man",
        "toggleterm",
        "lazy",
    },
    callback = function()
        vim.b.miniindentscope_disable = true
    end,
})
