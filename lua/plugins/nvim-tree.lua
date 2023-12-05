return {
    -- file tree
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        -- mappings
        local function on_attach(bufnr)
            local api = require("nvim-tree.api")

            local function opts(desc)
                return {
                    desc = "nvim-tree: " .. desc,
                    buffer = bufnr,
                    noremap = true,
                    silent = true,
                    nowait = true,
                }
            end

            -- for shorter code
            local nmap = function(lhs, rhs, opt)
                vim.keymap.set("n", lhs, rhs, opt)
            end

            nmap("<C-]>", api.tree.change_root_to_node, opts("CD"))
            nmap("<nop>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
            nmap("<C-k>", api.node.show_info_popup, opts("Info"))
            nmap("<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
            nmap("<C-t>", api.node.open.tab, opts("Open: New Tab"))
            nmap("<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
            nmap("<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
            nmap("<BS>", api.node.navigate.parent_close, opts("Close Directory"))
            nmap("<CR>", api.node.open.edit, opts("Open"))
            nmap("<Tab>", api.node.open.preview, opts("Open Preview"))
            nmap(">", api.node.navigate.sibling.next, opts("Next Sibling"))
            nmap("<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
            nmap(".", api.node.run.cmd, opts("Run Command"))
            nmap("-", api.tree.change_root_to_parent, opts("Up"))
            nmap("a", api.fs.create, opts("Create"))
            nmap("bmv", api.marks.bulk.move, opts("Move Bookmarked"))
            nmap("B", api.tree.toggle_no_buffer_filter, opts("Toggle No Buffer"))
            nmap("c", api.fs.copy.node, opts("Copy"))
            nmap("C", api.tree.toggle_git_clean_filter, opts("Toggle Git Clean"))
            nmap("[c", api.node.navigate.git.prev, opts("Prev Git"))
            nmap("]c", api.node.navigate.git.next, opts("Next Git"))
            nmap("d", api.fs.remove, opts("Delete"))
            nmap("D", api.fs.trash, opts("Trash"))
            nmap("E", api.tree.expand_all, opts("Expand All"))
            nmap("e", api.fs.rename_basename, opts("Rename: Basename"))
            nmap("]e", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
            nmap("[e", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
            nmap("F", api.live_filter.clear, opts("Clean Filter"))
            nmap("f", api.live_filter.start, opts("Filter"))
            nmap("g?", api.tree.toggle_help, opts("Help"))
            nmap("gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
            nmap("H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
            nmap("I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
            nmap("J", api.node.navigate.sibling.last, opts("Last Sibling"))
            nmap("K", api.node.navigate.sibling.first, opts("First Sibling"))
            nmap("m", api.marks.toggle, opts("Toggle Bookmark"))
            nmap("o", api.node.open.edit, opts("Open"))
            nmap("O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
            nmap("p", api.fs.paste, opts("Paste"))
            nmap("P", api.node.navigate.parent, opts("Parent Directory"))
            nmap("q", api.tree.close, opts("Close"))
            nmap("r", api.fs.rename, opts("Rename"))
            nmap("R", api.tree.reload, opts("Refresh"))
            nmap("s", api.node.run.system, opts("Run System"))
            nmap("S", api.tree.search_node, opts("Search"))
            nmap("U", api.tree.toggle_custom_filter, opts("Toggle Hidden"))
            nmap("W", api.tree.collapse_all, opts("Collapse"))
            nmap("x", api.fs.cut, opts("Cut"))
            nmap("y", api.fs.copy.filename, opts("Copy Name"))
            nmap("Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
            nmap("<2-LeftMouse>", api.node.open.edit, opts("Open"))
            nmap("<2-RightMouse>", api.tree.change_root_to_node, opts("CD"))
        end

        -- setup with some options
        require("nvim-tree").setup({
            on_attach = on_attach,
            sort_by = "case_sensitive",
            view = {
                adaptive_size = true,
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
                    window_picker = {
                        -- for example when using :vsplit
                        enable = true,
                        picker = "default",
                    },
                },
                remove_file = {
                    close_window = true,
                },
                use_system_clipboard = true,
            },
            ui = {
                confirm = {
                    remove = true,
                    trash = true,
                },
            },
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
                enable = false,
                show_on_dirs = false,
                show_on_open_dirs = false,
                severity = {
                    min = vim.diagnostic.severity.WARNING,
                    max = vim.diagnostic.severity.ERROR,
                },
            },
            system_open = {
                cmd = "",
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
                show_on_open_dirs = false,
            },
            filesystem_watchers = { -- improves performance
                enable = true,
            },
            notify = {
                threshold = vim.log.levels.ERROR,
            },
        })

        vim.keymap.set(
            { "n", "i" },
            "<C-b>",
            vim.cmd.NvimTreeToggle,
            { desc = "nvim-tree: Toggle" }
        )
    end,
}
