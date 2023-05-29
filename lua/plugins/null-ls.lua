return {
    "jose-elias-alvarez/null-ls.nvim",
    ft = { 'c', 'cpp' },
    dependencies = {
        { "nvim-lua/plenary.nvim" },
    },
    -- for now needed only for clang_format setup
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.clang_format.with({
                    extra_args = { "--style", "Microsoft" },
                }),
            }
        })

        -- happens when lsp and null-ls are both attached to the same buffer
        -- see https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428
        local notify = vim.notify
        vim.notify = function(msg, ...)
            if msg:match("warning: multiple different client offset_encodings") then
                return
            end

            notify(msg, ...)
        end
    end
}
