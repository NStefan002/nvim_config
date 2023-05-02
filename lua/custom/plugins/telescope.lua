return {
    -- Fuzzy finder
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        -- or                          , branch = '0.1.1',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local nmap = function(keys, func, desc)
                if desc then
                    desc = 'Telescope: ' .. desc
                end

                vim.keymap.set('n', keys, func, { desc = desc })
            end
            -- !!! Very useful !!! https://github.com/nvim-telescope/telescope.nvim#pickers
            local builtin = require("telescope.builtin")
            nmap("<leader>sf", builtin.find_files, "[S]earch [F]iles")
            nmap("<leader>gf", builtin.git_files, "Search [G]it [F]iles")
            nmap("<leader>gs", function()
                builtin.grep_string({ search = vim.fn.input("Grep --> ") })
            end, "[G]rep [S]tring")
            nmap("<leader>lg", builtin.live_grep, "[L]ive [G]rep")
            nmap("<leader>sh", builtin.help_tags, "[S]earch [H]elp")
            nmap("<leader>sr", builtin.oldfiles, "[S]earch [R]ecently opened files")
            nmap("<leader>sd", builtin.diagnostics, "[S]earch [D]iagnostics")
            nmap("<leader>sb", builtin.buffers, "[S]earch [B]uffers")
            nmap("<leader>st", builtin.treesitter, "[S]earch [T]reesitter")
            nmap("ff", "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Current Buffer [Fuzzy] [F]inder")

            -- overview of all mappings
            nmap("<leader>key", "<cmd>Telescope keymaps<CR>", "[Key]maps")
        end
    },
}
