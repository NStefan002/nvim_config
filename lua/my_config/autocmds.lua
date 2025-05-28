local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local aucmdsStarterPack = augroup("aucmdsStarterPack", { clear = true })

autocmd("TextYankPost", {
    group = aucmdsStarterPack,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 40 })
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
        "checkhealth",
        "help",
        "man",
        "notify",
        "screenkey_log",
        "snacks_notif",
        "vim", -- for opening commands history on accident with q:
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
    end,
    desc = "exit certain files with just 'q'",
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

autocmd("FileType", {
    group = aucmdsStarterPack,
    pattern = {
        "snacks_terminal",
    },
    callback = function(ev)
        -- NOTE: we need to wait a little bit for program to open up
        vim.defer_fn(function()
            vim.keymap.set(
                "t",
                "TN",
                "<cmd>tabnext<cr>",
                { buffer = ev.buf, desc = "[snacks terminal] move to next tab" }
            )
            vim.keymap.set(
                "t",
                "TP",
                "<cmd>tabprevious<cr>",
                { buffer = ev.buf, desc = "[snacks terminal] move to previous tab" }
            )
        end, 1000)
    end,
    desc = "set specific keymaps for snacks terminal",
})

autocmd("WinClosed", {
    group = aucmdsStarterPack,
    pattern = "*",
    callback = function(ev)
        local name = vim.api.nvim_buf_get_name(ev.buf)
        local start, _, _ = name:find("lazygit")
        local is_lazygit = start ~= nil
        if is_lazygit then
            vim.cmd("tabclose")
        end
    end,
    desc = "close tab if lazygit window is closed",
})

autocmd("ColorScheme", {
    group = aucmdsStarterPack,
    callback = function()
        require("my_config.util.tabline").set_hl_groups()
    end,
    desc = "change some default colors",
})

autocmd("VimEnter", {
    group = aucmdsStarterPack,
    pattern = "*",
    callback = function()
        if vim.api.nvim_buf_get_name(0) == "" then
            vim.opt_local.fillchars = { eob = " " }
        end
    end,
    desc = "remove '~' when dashboard is active",
})
