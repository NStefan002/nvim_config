return {
    dev = false,
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<C-h>" },
        { "<C-l>" },
        { "<C-f>" },
        { "<C-1>" },
        { "<C-2>" },
        { "<C-3>" },
        { "<C-e>" },
        { "<leader>a" },
    },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()
        vim.keymap.set("n", "<leader>a", function()
            harpoon:list():add()
        end, { desc = "Harpoon: [a]dd to list" })
        vim.keymap.set("n", "<C-e>", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Harpoon: toggle quick menu" })

        vim.keymap.set("n", "<C-h>", function()
            harpoon:list():select(1)
        end, { desc = "Harpoon: goto 1st buffer in the list" })
        vim.keymap.set("n", "<C-l>", function()
            harpoon:list():select(2)
        end, { desc = "Harpoon: goto 2nd buffer in the list" })
        vim.keymap.set("n", "<C-f>", function()
            harpoon:list():select(3)
        end, { desc = "Harpoon: goto 3rd buffer in the list" })
        vim.keymap.set("n", "<C-1>", function()
            harpoon:list():select(4)
        end, { desc = "Harpoon: goto 4th buffer in the list" })
        vim.keymap.set("n", "<C-2>", function()
            harpoon:list():select(5)
        end, { desc = "Harpoon: goto 5th buffer in the list" })
        vim.keymap.set("n", "<C-3>", function()
            harpoon:list():select(6)
        end, { desc = "Harpoon: goto 6th buffer in the list" })
    end,
}
