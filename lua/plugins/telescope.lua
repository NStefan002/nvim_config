return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "debugloop/telescope-undo.nvim",
    },
    keys = {
        { "<leader>tu", desc = "[T]elescope [U]ndo" },
        { "<leader>nh", desc = "[N]otification [H]istory" },
    },
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

        vim.keymap.set(
            "n",
            "<leader>tu",
            "<cmd>Telescope undo<CR>",
            { desc = "[T]elescope [U]ndo" }
        )
        vim.keymap.set(
            "n",
            "<leader>nh",
            "<cmd>Telescope notify<CR>",
            { desc = "[N]otification [H]istory" }
        )
    end,
}
