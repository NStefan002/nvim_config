return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
        local nmap_fzf = function(keys, cmd, desc)
            if desc then
                desc = "FzfLua: " .. desc
            end

            vim.keymap.set("n", keys, string.format("<cmd>FzfLua %s<cr>", cmd), { desc = desc })
        end

        -- buffers and files
        nmap_fzf("<leader>sf", "files", "[S]earch [F]iles")
        nmap_fzf("<leader>sb", "buffers", "[S]earch [B]uffers")

        -- search
        nmap_fzf("<leader>lg", "live_grep_native", "[L]ive [G]rep")
        nmap_fzf("<leader>gw", "grep_cword", "[G]rep c[w]ord")
        nmap_fzf("<leader>gW", "grep_cWORD", "[G]rep c[W]ORD")

        --git
        nmap_fzf("<leader>gf", "git_files", "Search [G]it [F]iles")

        -- lsp
        nmap_fzf("<leader>sd", "diagnostics_workspace", "[S]earch [D]iagnostics")

        -- nvim
        nmap_fzf("<leader>key", "keymaps", "[Key]maps")
        nmap_fzf("<leader>sh", "helptags", "[S]earch [H]elp")
    end,
}
