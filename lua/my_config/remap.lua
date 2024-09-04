-- basics
vim.g.mapleader = " " -- ("<space>")
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- terminal mappings (experimental)
vim.keymap.set("n", "<leader>tv", "<c-w><c-v><cmd>term<CR>", { desc = "Open terminal in vsplit" })
vim.keymap.set("n", "<leader>ts", "<c-w><c-s><cmd>term<CR>", { desc = "Open terminal in split" })
vim.keymap.set("t", "<c-j><c-k>", "<c-\\><c-n>", { desc = "Exit insert mode in terminal" })

-- buffers
vim.keymap.set("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "[b", "<cmd>bprev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "X", "<cmd>bdelete<CR>", { desc = "Close buffer" })

-- quickfix
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz", { desc = "Next quickfix item" })
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz", { desc = "Previous quickfix item" })

-- resizing windows
vim.keymap.set("n", "<C-Up>", "<cmd>horizontal resize -3<CR>", { desc = "Dec. window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>horizontal resize +3<CR>", { desc = "Inc. window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize +3<CR>", { desc = "Inc. window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize -3<CR>", { desc = "Dec. window width" })

-- some default keymaps enhanced
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

vim.keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz", { desc = "Scroll down half screen" })
vim.keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz", { desc = "Scroll up half screen" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Move to next search result and center it" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Move to previous search result and center it" })

-- copy pasta stuff
vim.keymap.set(
    "x",
    "<C-p>",
    [["_dP]],
    { desc = "Paste yanked text over some other text and keep the first text in the register" }
)
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]], { desc = "Paste from system clipboard" })
vim.keymap.set(
    "n",
    "<leader>A",
    'mzGVgg"+y`zzz',
    { desc = "Copy entire buffer to system clipboard and preserve the cursor position" }
)
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete != cut" })

-- disable certain keymaps
vim.keymap.set("n", "<space>", "<nop>")
vim.keymap.set("n", "<backspace>", "<nop>")
vim.keymap.set("n", "L", "<nop>")
vim.keymap.set("n", "H", "<nop>")

vim.keymap.set(
    "n",
    "<leader>R",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Change all ocurences of the word that's under the cursor" }
)

vim.keymap.set(
    "n",
    "<leader>x",
    "<cmd>!chmod +x %<CR>",
    { silent = true, desc = "Make the current file executable" }
)

vim.keymap.set(
    "n",
    "<leader><leader>s",
    "<cmd>w<CR><cmd>source %<CR>",
    { silent = true, desc = "Save and source current file" }
)

vim.keymap.set("n", "<leader>hl", function()
    vim.opt_local.hlsearch = not vim.opt_local.hlsearch:get()
end, { silent = true, desc = "Toggle [hl]search" })

vim.keymap.set("n", "<leader>W", function()
    vim.opt.wrap = not vim.opt.wrap:get()
end, { silent = true, desc = "Toggle [W]rap" })

-- cmdline
vim.keymap.set("c", "<c-h>", "<left>", { desc = "Move cursor left in command mode" })
vim.keymap.set("c", "<c-l>", "<right>", { desc = "Move cursor left in command mode" })
vim.keymap.set("c", "<c-j>", "<down>", { desc = "Move cursor left in command mode" })
vim.keymap.set("c", "<c-k>", "<up>", { desc = "Move cursor left in command mode" })

-- diagnostics
vim.keymap.set("n", "<leader>of", vim.diagnostic.open_float, { desc = "[O]pen [F]loating window" })
vim.keymap.set("n", "]d", function()
    vim.diagnostic.goto_next()
    vim.cmd("normal zz")
end, { desc = "Next diagnostic" })
vim.keymap.set("n", "[d", function()
    vim.diagnostic.goto_prev()
    vim.cmd("normal zz")
end, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]e", function()
    vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
    vim.cmd("normal zz")
end, { desc = "Next error" })
vim.keymap.set("n", "[e", function()
    vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
    vim.cmd("normal zz")
end, { desc = "Previous error" })
vim.keymap.set("n", "]w", function()
    vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
    vim.cmd("normal zz")
end, { desc = "Next warning" })
vim.keymap.set("n", "[w", function()
    vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
    vim.cmd("normal zz")
end, { desc = "Previous warning" })

-- builtin plugins

-- netrw
-- vim.keymap.set("n", "<C-b>", "<cmd>Ex<CR>", { desc = "Open the file explorer" })

-- comment
-- vim.keymap.set({ "n", "x", "o" }, "<leader>c", "gc", { remap = true })
