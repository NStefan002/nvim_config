local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local aucmdsStarterPack = augroup('aucmdsStarterPack', { clear = true })

autocmd("TextYankPost", {
    group = aucmdsStarterPack,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
    desc = "highlight yanked text"
})

autocmd("BufWritePre", {
    group = aucmdsStarterPack,
    pattern = "*",
    command = [[%s/\s\+$//e]],
    desc = "remove trailing spaces"
})

autocmd("FileType", {
    group = aucmdsStarterPack,
    pattern = {
        'help',
        'vim', -- for opening commands history on accident with q:
        'man',
        'checkhealth',
        'notify',
        'fugitive',
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = event.buf, silent = true })
    end,
    desc = "exit certain files with just 'q'"
})

autocmd("BufWritePre", {
    group = aucmdsStarterPack,
    pattern = {
        '*.lua',
        '*.js',
        '*.ts',
        '*.html',
        '*.py',
        '*.rs'
    },
    callback = function()
        vim.lsp.buf.format()
    end,
    desc = "autoformat certain files on save"
})

autocmd("ColorScheme", {
    group = aucmdsStarterPack,
    pattern = "*",
    callback = function()
        local hl = vim.api.nvim_set_hl
        hl(0, 'Search', { link = 'IncSearch' })
        hl(0, 'CurSearch', { undercurl = true, italic = true, fg = "lime" })

        -- FIX: temporary solution for float titles (solution is to use Neovim-specific colorschemes)
        -- NOTE: this has nothing to do with transparent.nvim, rather it's a non-Neovim colorschemes issue
        hl(0, "LspInlayHint", { link = "Comment" })
        hl(0, "FloatTitle", { link = "Error" })

        hl(0, "FoldColumn", {})
    end,
    desc = "Update hlgroups for / and ?, fix some highlights"
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
