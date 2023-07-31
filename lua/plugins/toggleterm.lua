return {
    -- terminal windows
    'akinsho/toggleterm.nvim',
    version = "*",
    lazy = false,
    cond = function()
        return vim.g.neovide
    end,
    opts = {
        open_mapping = [[<C-Bslash>]],
        size = 49,
        hide_numbers = true,
        shade_terminals = true,
        shading_factor = -100,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "vertical", -- 'vertical' | 'horizontal' | 'float' | 'tab'
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
            border = "double", -- use 'curved' if direction='float'
        },
    },
    config = function(_, opts)
        require("toggleterm").setup(opts)
        function _G.set_terminal_keymaps()
            local opts = {}
            vim.keymap.set("t", "jj", [[<C-\><C-n>]], { buffer = 0, noremap = true, desc = "Enter Normal Mode" })
            vim.keymap.set("n", "<C-h>", [[<C-\><C-n><C-W>h]],
                { buffer = 0, noremap = true, desc = "Enter Normal Mode" })
            vim.keymap.set("n", "<C-j>", [[<C-\><C-n><C-W>j]],
                { buffer = 0, noremap = true, desc = "Enter Normal Mode" })
            vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-W>j]],
                { buffer = 0, noremap = true, desc = "Enter Normal Mode" })
            vim.keymap.set("n", "<C-k>", [[<C-\><C-n><C-W>k]],
                { buffer = 0, noremap = true, desc = "Enter Normal Mode" })
            vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-W>k]],
                { buffer = 0, noremap = true, desc = "Enter Normal Mode" })
            -- ctrl + l in normal mode because of zsh default ctrl + l = 'clear' and moving to terminal left/right is less used in this setup
            vim.keymap.set("n", "<C-l>", [[<C-\><C-n><C-W>l]],
                { buffer = 0, noremap = true, desc = "Enter Normal Mode" })
        end

        -- having multiple terminals open is possible only in vertical and horizontal mode
        -- opening terminal with index i can be done with i<C-Bslash> (i is integer number)

        vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"
    end
}
