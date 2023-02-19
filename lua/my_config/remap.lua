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
vim.keymap.set("v", "<C-y>", [["+y]])
vim.keymap.set("n", "<C-p>", [["+p]])

-- possibly set previous commands to this, and remove C-y/C-p
vim.keymap.set("n", "<leader>y", "yy")
vim.keymap.set("n", "<leader>d", "dd")

-- delete != cut
vim.keymap.set({ "n", "v" }, "<leader>D", [["_d]])

-- vim.keymap.set("n", "Q", "<nop>")

-- -- jumping to next/prev error in file list (:help cnext/lnext)
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Packer (install and/or update plugins with :PackerSync)
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/my_config/packer.lua<CR>");



-- NOTE: almost all of the following mapings are defined in
-- the plugin config files and are here just as a reminder
-- FIX: This needs rework (try to place all of the mappings in one file)

-- NvimTree
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) NOTE: only uncomment if there is no NvimTree
-- vim.keymap.set({ "n", "v" }, "<C-b>", vim.cmd.NvimTreeToggle) -- like VSC
-- vim.keymap.set("n", "C", "<cmd>NvimTreeCollapse<CR>")

-- ToggleTerm
-- open_mapping = [[<C-Bslash>]]
-- local opts = { noremap = true }
-- vim.api.nvim_buf_set_keymap(0, "t", "jj", [[<C-\><C-n>]], opts)
-- vim.api.nvim_buf_set_keymap(0, "n", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
-- vim.api.nvim_buf_set_keymap(0, "n", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
-- vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
-- vim.api.nvim_buf_set_keymap(0, "n", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
-- vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
-- vim.api.nvim_buf_set_keymap(0, "n", "<C-l>", [[<C-\><C-n><C-W>l]], opts) -- ctrl + l in normal mode because of zsh default ctrl + l = 'clear' and moving to terminal left/right is less used in this setup
-- Fugitive
-- vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- LSP
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- DAP
-- vim.keymap.set("n", "<F6>", "<cmd>lua require'dap'.continue()<CR>")
-- vim.keymap.set("n", "<F7>", "<cmd>lua require'dap'.step_over()<CR>")
-- vim.keymap.set("n", "<F8>", "<cmd>lua require'dap'.step_into()<CR>")
-- vim.keymap.set("n", "<F9>", "<cmd>lua require'dap'.step_out()<CR>")
-- vim.keymap.set("n", "<leader>b", "<cmd>lua require'dap'.toggle_breakpoint()<CR>")
-- vim.keymap.set("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
-- vim.keymap.set("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")

-- Tagbar
-- vim.keymap.set("n", "<F5>", "<cmd>TagbarToggle<CR>")

-- Telescope
-- vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
-- vim.keymap.set("n", "<leader>ff", builtin.git_files, {})
-- vim.keymap.set("n", "<leader>ps", function()
--     builtin.grep_string({ search = vim.fn.input("Grep --> ") });
-- end)

-- Trouble
-- vim.keymap.set("n", "<C-M>", "<cmd>TroubleToggle<CR>") -- like in VSC

-- UndoTree
-- vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
