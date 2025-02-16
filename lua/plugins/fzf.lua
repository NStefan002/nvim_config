return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
        require("fzf-lua").setup({
            "default-title",
            keymap = {
                builtin = {
                    ["<c-d>"] = "preview-page-down",
                    ["<c-u>"] = "preview-page-up",
                },
                fzf = {
                    ["ctrl-q"] = "select-all+accept",
                },
            },
            previewers = {
                builtin = {
                    extensions = {
                        ["png"] = { "chafa", "{file}" },
                        ["svg"] = { "chafa", "{file}" },
                        ["jpg"] = { "chafa", "{file}" },
                    },
                },
            },
        })

        ---@param lhs string
        ---@param rhs string
        ---@param desc string
        ---@param modes? string[]
        local function map(lhs, rhs, desc, modes)
            desc = "FzfLua: " .. desc
            modes = modes or { "n" }
            vim.keymap.set(modes, lhs, string.format("<cmd>FzfLua %s<cr>", rhs), { desc = desc })
        end

        -- buffers and files
        map("<leader>sf", "files", "[S]earch [F]iles")
        map("<leader>sb", "buffers", "[S]earch [B]uffers")

        -- search
        map("<leader>lg", "live_grep_native", "[L]ive [G]rep")
        map("<leader>gw", "grep_cword", "[G]rep c[w]ord")
        map("<leader>gW", "grep_cWORD", "[G]rep c[W]ORD")
        map("<leader>gv", "grep_visual", "[G]rep [V]isual", { "v" })

        --git
        map("<leader>gf", "git_files", "Search [G]it [F]iles")

        -- lsp
        map("<leader>sd", "diagnostics_workspace", "[S]earch [D]iagnostics")

        -- nvim
        map("<leader>key", "keymaps", "[Key]maps")
        map("<leader>sh", "helptags", "[S]earch [H]elp")
        map("<leader>:", "command_history", "[C]ommandline [H]istory")
    end,
}
