return {
    "numToStr/Comment.nvim",
    event = "BufEnter",
    opts = {
        padding = true,
        sticky = true,
        toggler = {
            line = "<leader>cc",
            block = "<leader>cb",
        },
        ---LHS of operator-pending mappings in NORMAL and VISUAL mode
        opleader = {
            line = "<leader>c",
            block = "<leader>b",
        },
        ---Enable keybindings
        ---NOTE: If given `false` then the plugin won't create any mappings
        mappings = {
            basic = true,
            extra = false,
        },
    },
}
