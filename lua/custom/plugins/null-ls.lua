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
    end
}
