return {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
        local lint = require("lint")
        lint.linters_by_ft = {
            go = { "golangcilint" },
            javascript = { "eslint_d" },
            lua = { "luacheck" },
            markdown = { "markdownlint" },
            text = { "cspell" },
            typescript = { "eslint_d" },
        }
        -- change the severity of all diagnostics produced by cspell
        lint.linters.cspell = require("lint.util").wrap(lint.linters.cspell, function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity.HINT
            return diagnostic
        end)
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end,
}
