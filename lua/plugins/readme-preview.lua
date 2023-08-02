return {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = { "markdown" },
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
}
