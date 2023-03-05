-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- setup with some options
require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
        adaptive_size = true,
        mappings = {
            list = {
                { key = "u", action = "dir_up" },
            },
        },
    },
    renderer = {
        add_trailing = true, -- add '/' at the end of directory name
        group_empty = true, -- compact folders that only contain a single folder into one node in the file tree
        full_name = false, -- disable showing very long names in floating window
        highlight_git = true,
        highlight_opened_files = "name",
        symlink_destination = true,
    },
    actions = {
        open_file = {
            quit_on_open = false,
            resize_window = true,
            window_picker = { -- for example when using :vsplit
                enable = true,
                picker = "default",
            },
        },
        remove_file = {
            close_window = true,
        },
        use_system_clipboard = true,
    },
    -- ui = {
    --     confirm = {
    --         remove = true,
    --         trash = true,
    --     },
    -- },
    filters = {
        dotfiles = true,
    },
    auto_reload_on_write = true,
    hijack_unnamed_buffer_when_opening = false,
    hijack_cursor = true, -- keeps the cursor on the first letter of the filename
    update_focused_file = {
        enable = true,
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
        severity = {
            min = vim.diagnostic.severity.WARNING,
            max = vim.diagnostic.severity.ERROR,
        },
    },
    system_open = {
        cmd = ""
    },
    git = {
        enable = true,
        ignore = true, -- togle mapping is I
        show_on_dirs = true,
        show_on_open_dirs = true,
    },
    modified = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
    },
    filesystem_watchers = { -- improves performance
        enable = true,
    },
})

-- mappings
vim.keymap.set({ "n", "v" }, "<C-b>", vim.cmd.NvimTreeToggle, { desc = "Toggle NvimTree" }) -- like VSC
vim.keymap.set("n", "C", "<cmd>NvimTreeCollapse<CR>", { desc = "[C]ollapse NvimTree" })
