-- !!! Very useful !!! https://github.com/nvim-telescope/telescope.nvim#pickers
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Search [G]it [F]iles" })
vim.keymap.set("n", "<leader>gs", function()
    builtin.grep_string({ search = vim.fn.input("Grep --> ") });
end, { desc = "[G]rep [S]tring" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sr", builtin.oldfiles, { desc = "[S]earch [R]ecently opened files" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
