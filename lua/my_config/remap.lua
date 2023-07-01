-- basics
vim.g.mapleader = " " -- ("<space>")
vim.keymap.set("i", "jj", "<Esc>")

-- vertical split
vim.keymap.set("n", "<C-s>", [[:vsplit ]])

-- tabs
vim.keymap.set("n", "<leader>tn", [[:tabnew ]])
vim.keymap.set("n", "<C-}>", "<cmd>tabnext<CR>")
vim.keymap.set("n", "<C-{>", "<cmd>tabprev<CR>")

-- buffers
vim.keymap.set("n", "<C-l>", "<cmd>bnext<CR>")
vim.keymap.set("n", "<C-h>", "<cmd>bprev<CR>")

-- resizing windows
vim.keymap.set("n", "<C-Up>", "<cmd>horizontal resize -3<CR>")
vim.keymap.set("n", "<C-Down>", "<cmd>horizontal resize +3<CR>")
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize +3<CR>")
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize -3<CR>")

-- same as Alt + up/down in VSC
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- very useful for quick navigation in medium to large size files
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- some weird things
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- e.g. copying highlighted text over other text so the first text stays in buffer
vim.keymap.set("x", "<C-p>", [["_dP]])

-- copying and pasting to/from system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]])

-- delete != cut
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- disable certain keymaps
vim.keymap.set("n", "<space>", "<nop>")
vim.keymap.set("n", "<backspace>", "<nop>")
vim.keymap.set("n", "L", "<nop>")
vim.keymap.set("n", "H", "<nop>")

-- change all ocurences of the word that's under the cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- save and source current file
vim.keymap.set("n", "<leader><leader>s", "<cmd>w<CR><cmd>source %<CR>", { silent = true })

vim.keymap.set("n", "<leader>hl", function()
    vim.opt_local.hlsearch = not vim.opt_local.hlsearch:get()
end, { desc = "Toggle [hl]search", silent = true })
