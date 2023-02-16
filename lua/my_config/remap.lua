vim.g.mapleader = " " -- ("<space>")

-- File tree
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set({ "n", "v" }, "<C-b>", vim.cmd.NvimTreeToggle) -- like VSC
vim.keymap.set({ "n", "v" }, "<leader>pc", vim.cmd.NvimTreeCollapse)

vim.keymap.set("i", "jj", "<Esc>")

-- vertical split
vim.keymap.set("n", "<C-s>", [[:vsplit ]])

-- tabs
vim.keymap.set("n", "<leader>tn", [[:tabnew ]])
vim.keymap.set("n", "<C-l>", "<cmd>tabnext<CR>")
vim.keymap.set("n", "<C-h>", "<cmd>tabprev<CR>")

-- resizing windows
vim.keymap.set("n", "<C-Up>", "<cmd>horizontal resize +3<CR>")
vim.keymap.set("n", "<C-Down>", "<cmd>horizontal resize -3<CR>")
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize +3<CR>")
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize -3<CR>")

-- Terminal
-- vim.keymap.set("n", "<leader>`", "<cmd>:ToggleTerm size=50 direction=vertical<CR>")
-- vim.keymap.set({"n", "i"}, "<C-`>", "<cmd>:ToggleTerm size=50 direction=vertical<CR>")
-- vim.keymap.set("n", "<leader>`", vim.cmd.ToggleTerm)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- e.g. copying highlighted text over other text so the first text stays in buffer
vim.keymap.set("x", "<leader>p", [["_dP]])

-- copying and pasting to/from system clipboard
vim.keymap.set("v", "<C-y>", [["+y]])
vim.keymap.set("n", "<C-p>", [["+p]])

vim.keymap.set("n", "<leader>y", "yy")
vim.keymap.set("n", "<leader>d", "dd")

-- delete != cut
vim.keymap.set({ "n", "v" }, "<leader>D", [["_d]])

-- vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- -- jumping to next/prev error in file list (:help cnext/lnext)
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Packer
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/my_config/packer.lua<CR>");

-- NvimTree
vim.keymap.set("n", "C", "<cmd>NvimTreeCollapse<CR>")
