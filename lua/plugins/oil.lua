return {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    config = function()
        vim.keymap.set("n", "<C-b>", "<cmd>Oil<CR>", { desc = "Open Oil" })
        require("oil").setup({
            default_file_explorer = true,
            columns = {
                "icon",
                -- "permissions",
                -- "size",
                -- "mtime",
            },
            win_options = {
                number = false,
                relativenumber = false,
            },
            delete_to_trash = false,
            skip_confirm_for_simple_edits = false,
            -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
            prompt_save_on_select_new_entry = true,
            constrain_cursor = "editable", -- "false" | "name" | "editable"
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-v>"] = "actions.select_vsplit",
                ["<C-s>"] = "actions.select_split",
                ["<C-t>"] = "actions.select_tab",
                ["<C-p>"] = "actions.preview",
                ["<C-b>"] = "actions.close",
                ["<C-R>"] = "actions.refresh",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = "actions.tcd",
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
                ["g\\"] = "actions.toggle_trash",
            },
            -- Set to false to disable all of the above keymaps
            use_default_keymaps = false,
            float = {
                border = "double",
            },
            -- Configuration for the actions floating preview window
            preview = {
                -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                -- min_width and max_width can be a single value or a list of mixed integer/float types.
                -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
                max_width = 0.9,
                -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
                min_width = { 40, 0.4 },
                -- optionally define an integer/float for the exact width of the preview window
                width = nil,
                -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                -- min_height and max_height can be a single value or a list of mixed integer/float types.
                -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
                max_height = 0.9,
                -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
                min_height = { 5, 0.1 },
                -- optionally define an integer/float for the exact height of the preview window
                height = nil,
                border = "double",
                win_options = {
                    winblend = 0,
                },
                -- Whether the preview window is automatically updated when the cursor is moved
                update_on_cursor_moved = true,
            },
            -- Configuration for the floating progress window
            progress = {
                max_width = 0.9,
                min_width = { 40, 0.4 },
                width = nil,
                max_height = { 10, 0.9 },
                min_height = { 5, 0.1 },
                height = nil,
                border = "rounded",
                minimized_border = "none",
                win_options = {
                    winblend = 0,
                },
            },
            -- Configuration for the floating SSH window
            ssh = {
                border = "rounded",
            },
            view_options = {
                show_hidden = true,
            },
        })
    end,
}
