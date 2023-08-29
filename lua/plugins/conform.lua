return {
    'stevearc/conform.nvim',
    lazy = false,
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                c = { "clang_format" },
                cpp = { "clang_format" },
                javascript = { "prettierd", "prettier" },
            },
        })

        -- format on keymap
        vim.keymap.set({ "n", "v" }, "<leader>f", function()
            conform.format({
                async = true,
                lsp_fallback = true
            })
        end, { desc = "[F]ormat File" })
        -- foramt on save
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function(args)
                -- Disable autoformat on certain filetypes
                local ignore_filetypes = {}
                if vim.tbl_contains(ignore_filetypes, vim.bo[args.buf].filetype) then
                    return
                end
                conform.format({
                    buf = args.buf,
                    async = true,
                    lsp_fallback = false,
                })
            end
        })
    end
}
