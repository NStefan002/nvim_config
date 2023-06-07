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
        'lspinfo',
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
        '*.css',
        '*.py',
        '*.rs'
    },
    callback = function()
        vim.lsp.buf.format()
    end,
    desc = "autoformat certain files on save"
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
