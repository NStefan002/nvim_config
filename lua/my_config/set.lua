-- line block cursor
vim.opt.guicursor = ""

-- line numbering
vim.opt.nu = true
vim.opt.relativenumber = true

-- tab
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- / and ?
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "80"

-- colorscheme on start
vim.cmd.colorscheme("gotham256")
vim.api.nvim_set_hl(0, "Normal", { bg = "none"} )
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"} )
