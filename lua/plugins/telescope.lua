return {
    -- Fuzzy finder

    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "debugloop/telescope-undo.nvim",
    },
    event = "BufEnter",
    config = function()
        require("telescope").setup({
            extensions = {
                undo = {
                    side_by_side = true,
                    layout_strategy = "vertical",
                    layout_config = {
                        preview_height = 0.8,
                    },
                },
            },
            defaults = {
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                    },
                },
            },
            pickers = {
                find_files = {
                    layout_strategy = "horizontal",
                    layout_config = {
                        width = 0.95,
                    },
                },
                live_grep = {
                    layout_strategy = "horizontal",
                    layout_config = {
                        width = 0.95,
                    },
                },
            },
        })

        require("telescope").load_extension("undo")
        require("telescope").load_extension("notify")

        local nmap = function(keys, func, desc)
            if desc then
                desc = "Telescope: " .. desc
            end

            vim.keymap.set("n", keys, func, { desc = desc })
        end
        local builtin = require("telescope.builtin")
        nmap("<leader>sf", builtin.find_files, "[S]earch [F]iles")
        nmap("<leader>gf", builtin.git_files, "Search [G]it [F]iles")
        nmap("<leader>lg", builtin.live_grep, "[L]ive [G]rep")
        nmap("<leader>sh", builtin.help_tags, "[S]earch [H]elp")
        nmap("<leader>sr", builtin.oldfiles, "[S]earch [R]ecently opened files")
        nmap("<leader>sd", builtin.diagnostics, "[S]earch [D]iagnostics")
        nmap("<leader>sb", builtin.buffers, "[S]earch [B]uffers")
        nmap("<leader>st", builtin.treesitter, "[S]earch [T]reesitter")
        nmap("<leader>key", builtin.keymaps, "[Key]maps")
        nmap("<leader>tu", "<cmd>Telescope undo<CR>", "[T]elescope [U]ndo")
        nmap("<leader>nh", "<cmd>Telescope notify<CR>", "[N]otification [H]istory")
        nmap("<leader>gs", builtin.grep_string, "Telescope: [G]rep [S]tring")
    end,
}
