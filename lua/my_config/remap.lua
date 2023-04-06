-- basics
vim.g.mapleader = " " -- ("<space>")
vim.keymap.set("i", "jj", "<Esc>")

-- vertical split
vim.keymap.set("n", "<C-s>", [[:vsplit ]])

-- tabs
vim.keymap.set("n", "<leader>tn", [[:tabnew ]])
vim.keymap.set("n", "<C-l>", "<cmd>tabnext<CR>")
vim.keymap.set("n", "<C-h>", "<cmd>tabprev<CR>")

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
vim.keymap.set("x", "<leader>p", [["_dP]])

-- copying and pasting to/from system clipboard
vim.keymap.set("v", "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>p", [["+p]])

-- delete != cut
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- disable certain keymaps
vim.keymap.set("n", "<space>", "<nop>")
vim.keymap.set("n", "<backspace>", "<nop>")
vim.keymap.set("n", "L", "<nop>")
vim.keymap.set("n", "H", "<nop>")

-- :help cnext/lnext
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- change all ocurences of the word that's under the cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Packer (install and/or update plugins with :PackerSync)
vim.keymap.set("n", "<leader>vpp", "<cmd>vsplit ~/.config/nvim/lua/my_config/packer.lua<CR>");

-- save and source current file
vim.keymap.set("n", "<leader><leader>s", "<cmd>w<CR><cmd>source %<CR>", { silent = true })

-- overview of all mappings
vim.keymap.set("n", "<leader>key", "<cmd>Telescope keymaps<CR>")
