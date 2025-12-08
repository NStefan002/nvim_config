return {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                bash = { "beautysh" },
                c = { "clang_format" },
                cpp = { "clang_format" },
                css = { "prettierd", "prettier" },
                go = { "goimports", "gofmt" },
                haskell = { "fourmolu" },
                html = { "prettierd", "prettier" },
                javascript = { "prettierd", "prettier" },
                json = { "prettierd", "prettier" },
                lua = { "stylua" },
                markdown = { "prettierd", "markdownlint", "injected", "prettier" },
                python = { "isort", "black" },
                sh = { "beautysh" },
                sql = { "sqlfmt" },
                templ = { "templ" },
                yaml = { "prettierd", "prettier" },
                zsh = { "beautysh" },
            },
        })

        conform.formatters.injected = {
            ignore_errors = true,
        }

        vim.keymap.set({ "n", "v" }, "<leader>f", function()
            conform.format({ async = true, lsp_fallback = true })
        end, { desc = "[F]ormat File" })

        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            group = vim.api.nvim_create_augroup("ConformAutoFormat", {}),
            callback = function(args)
                -- Disable autoformat on certain filetypes
                local ignore_filetypes = { "python", "markdown", "go" }
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

        -- set 'formatexpr'
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
