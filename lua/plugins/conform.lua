return {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                c = { "clang_format" },
                cpp = { "clang_format" },
                javascript = { "prettierd", "prettier" },
                html = { "prettierd", "prettier" },
                css = { "prettierd", "prettier" },
                markdown = { { "prettierd", "prettier" }, "injected" },
                zsh = { "beautysh" },
                bash = { "beautysh" },
                sh = { "beautysh" },
                python = { "isort", "black" },
            },
        })

        vim.keymap.set({ "n", "v" }, "<leader>f", function()
            conform.format({ async = true, lsp_fallback = true })
        end, { desc = "[F]ormat File" })

        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function(args)
                -- Disable autoformat on certain filetypes
                local ignore_filetypes = { "c", "cpp", "python" }
                if vim.tbl_contains(ignore_filetypes, vim.bo[args.buf].filetype) then
                    return
                end
                conform.format({
                    buf = args.buf,
                    async = false,
                    lsp_fallback = false,
                })
            end,
            desc = "Try to format files when saving.",
        })
    end,
}
