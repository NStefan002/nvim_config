return {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
        require("gitsigns").setup({
            attach_to_untracked = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "]g", function()
                    if vim.wo.diff then
                        return "]g"
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true })

                map("n", "[g", function()
                    if vim.wo.diff then
                        return "[g"
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true })

                -- Actions
                map("n", "<leader>ht", gs.toggle_current_line_blame)
                map("n", "<leader>hd", gs.diffthis)
                map("n", "<leader>hD", function()
                    gs.diffthis("~")
                end)

                -- Text object
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
            end,
        })
    end,
}
