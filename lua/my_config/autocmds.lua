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
        -- NOTE: not needed for 0.10.0+ default colorscheme, uncomment if you change colorscheme
        -- hl(0, "Search", { link = "IncSearch" })
        -- hl(0, "CurSearch", { undercurl = true, italic = true, fg = "lime" })
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

autocmd("FileType", {
    group = aucmdsStarterPack,
    pattern = {
        "gitcommit",
        "markdown",
    },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en"
    end,
    desc = "enable spellcheck for certain files",
})

autocmd("VimEnter", {
    group = aucmdsStarterPack,
    callback = function(ev)
        -- NOTE: uncomment this if you're using netrw instead of oil.nvim
        -- local is_dir = vim.fn.isdirectory(ev.file) == 1
        -- if is_dir then
        --     vim.cmd.cd(ev.file)
        -- end

        local entry = string.sub(ev.file, 7)
        if vim.fn.isdirectory(entry) == 1 then
            vim.cmd.cd(entry)
        end
    end,
    desc = "cd into directory if vim was opened with a directory as argument",
})

autocmd("FileType", {
    group = aucmdsStarterPack,
    pattern = {
        "netrw",
    },
    callback = function()
        vim.opt_local.fillchars = { eob = " " }
    end,
    desc = "remove '~' when netrw is active",
})
