return {
    "danymat/neogen",
    keys = { "<leader>nc" },
    cmd = "Neogen",
    config = function()
        local neogen = require("neogen")
        neogen.setup({})
        vim.keymap.set("n", "<leader>nc", function()
            neogen.generate()
        end, { noremap = true, silent = true })
    end,
}
