-- prettier colors
vim.opt.termguicolors = true

local block_cursor = "n-v-c-r-o:block"
local vertical_cursor = "i-ci:ver30"
local horizontal_cursor = "cr:hor25"
local blink = "n-i:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"
local cursor = block_cursor .. "," .. vertical_cursor .. "," .. horizontal_cursor .. "," .. blink
vim.opt.guicursor = cursor

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

-- wrapping lines
vim.opt.wrap = true
--[[ NOTE: uncomment when smoothscroll becomes complete
(currently works only for <C-e>, <C-y> and mouse scroll) ]]
--[[ vim.opt.smoothscroll = true ]]
vim.opt.showbreak = "==>  "

-- backup files
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

-- folds
vim.opt.foldcolumn = "1"
vim.opt.foldenable = true
vim.opt.foldmethod = "manual"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.fillchars:append({ fold = " ", foldopen = "", foldsep = " ", foldclose = "" })

function _G.Custom_fold()
    local line = vim.fn.getline(vim.v.foldstart)
    local line_count = vim.v.foldend - vim.v.foldstart + 1
    return " ⚡ " .. line .. ": " .. line_count .. " lines"
end

vim.wo.foldtext = "v:lua.Custom_fold()"

-- no idea what is this
vim.opt.isfname:append("@-@")

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

-- :h 'shortmess'
vim.opt.shm:append({ a = true, I = true, S = true })

-- colorscheme on start configured in nvim/lua/custom/plugins/colors.lua
