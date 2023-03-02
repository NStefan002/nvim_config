-- prettier colors
vim.opt.termguicolors = true

-- line block cursor
vim.opt.guicursor = ""

-- line numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- don't show mode (because lualine already shows it)
vim.opt.showmode = false

-- tab
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true

-- nesting code properly
vim.opt.smartindent = true

-- highlight matching parenthesis
vim.opt.showmatch = true

-- highlight current line
vim.opt.cursorline = false

-- how to split window
vim.opt.splitbelow = true
vim.opt.splitright = true

-- backup files
vim.opt.wrap = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- / and ?
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- tabline
vim.opt.tabline = ""
vim.opt.showtabline = 1

-- minimal number of lines to keep above/below cursor (if possible)
vim.opt.scrolloff = 8
-- displaying errors, warnings etc.
vim.opt.signcolumn = "yes"
-- no idea what is this
vim.opt.isfname:append("@-@")

-- vim.opt.colorcolumn = "80"

-- Enable background buffers
vim.opt.hidden = false
-- Remember N lines in history
vim.opt.history = 50
-- Faster scrolling
vim.opt.lazyredraw = true
-- Max column for syntax highlight
vim.opt.synmaxcol = 200
-- ms to wait for trigger an event
vim.opt.updatetime = 50

-- colorscheme on start
vim.cmd.colorscheme("gotham256")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
