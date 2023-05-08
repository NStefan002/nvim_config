local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local aucmdsStarterPack = augroup("aucmdsStarterPack", { clear = true })

-- highlight yanked text
autocmd('TextYankPost', {
    group = aucmdsStarterPack,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

-- remove trailing spaces
autocmd("BufWritePre", {
    group = aucmdsStarterPack,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- exit certain files with just 'q'
autocmd("FileType", {
    group = aucmdsStarterPack,
    pattern = {
        "help",
        "vim", -- for opening commands history on accident with q:
        "man",
        "checkhealth",
        "notify",
        "lspinfo"
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
    end
})
