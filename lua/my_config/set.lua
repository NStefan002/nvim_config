-- prettier colors
vim.opt.termguicolors = true

-- cursor
if vim.g.neovide then
    -- blinking cursor and line cursor looks bad in neovide
    vim.opt.guicursor = "" -- block cursor
else
    local block_cursor = "n-v-c-r-o:block"
    local vertical_cursor = "i-ci:ver30"
    local horizontal_cursor = "cr:hor25"
    local blink = "n-i:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"
    local cursor = block_cursor .. ',' .. vertical_cursor .. ',' .. horizontal_cursor .. ',' .. blink
    vim.opt.guicursor = cursor
end

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

-- disable startup message when opening empty buffer
vim.opt.shm:append({ I = true })

-- colorscheme on start configured in nvim/lua/custom/plugins/colors.lua
