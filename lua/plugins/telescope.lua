return {
    -- Fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
        -- or                          , branch = '0.1.1',
        dependencies = {
            "nvim-lua/plenary.nvim",
            "debugloop/telescope-undo.nvim",
        },
        event = "BufEnter",
        -- keys = {
        --     { "<leader>lg",  "<cmd>Telescope live_grep<CR>",                 desc = "[L]ive [G]rep" },
        --     { "<leader>sf",  "<cmd>Telescope find_files<CR>",                desc = "[S]earch [F]iles" },
        --     { "<leader>gf",  "<cmd>Telescope git_files<CR>",                 desc = "Search [G]it [F]iles" },
        --     { "<leader>lg",  "<cmd>Telescope live_grep<CR>",                 desc = "[L]ive [G]rep" },
        --     { "<leader>sh",  "<cmd>Telescope help_tags<CR>",                 desc = "[S]earch [H]elp" },
        --     { "<leader>sr",  "<cmd>Telescope oldfiles<CR>",                  desc = "[S]earch [R]ecently opened files" },
        --     { "<leader>sd",  "<cmd>Telescope diagnostics<CR>",               desc = "[S]earch [D]iagnostics" },
        --     { "<leader>sb",  "<cmd>Telescope buffers<CR>",                   desc = "[S]earch [B]uffers" },
        --     { "<leader>st",  "<cmd>Telescope treesitter<CR>",                desc = "[S]earch [T]reesitter" },
        --     { "ff",          "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Current Buffer [Fuzzy] [F]inder" },
        --     { "<leader>key", "<cmd>Telescope keymaps<CR>",                   desc = "[Key]maps" },
        --     { "<leader>tu",  "<cmd>Telescope undo<CR>",                      desc = "[T]elescope [U]ndo" },
        --     { "<leader>h",   "<cmd>Telescope notify<CR>",                    desc = "Notification [H]istory" },
        -- },
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
            -- !!! Very useful !!! https://github.com/nvim-telescope/telescope.nvim#pickers
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

            -- search for word under the cursor or visual selection
            vim.keymap.set(
                { "n", "v" },
                "<leader>gs",
                builtin.grep_string,
                { desc = "Telescope: [G]rep [S]tring" }
            )
        end,
    },
}
