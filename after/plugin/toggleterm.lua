require("toggleterm").setup {
    open_mapping = [[<C-Bslash>]],
    size = 49,
    hide_numbers = true,
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "vertical", -- 'vertical' | 'horizontal' | 'float' | 'tab'
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = "double", -- use 'curved' if direction='float'
    },
}

function _G.set_terminal_keymaps()
    local opts = { noremap = true }
    vim.api.nvim_buf_set_keymap(0, "t", "jj", [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, "n", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, "n", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, "n", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, "n", "<C-l>", [[<C-\><C-n><C-W>l]], opts) -- ctrl + l in normal mode because of zsh default ctrl + l = 'clear' and moving to terminal left/right is less used in this setup
end

vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"
