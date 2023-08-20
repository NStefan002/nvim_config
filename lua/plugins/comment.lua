return {
    'numToStr/Comment.nvim',
    event = "BufEnter",
    opts = {
        padding = true,
        sticky = true,
        toggler = {
            line = '<leader>cc',
            block = '<leader>cb',
        },
        ---LHS of operator-pending mappings in NORMAL and VISUAL mode
        opleader = {
            line = '<leader>c',
            block = 'gb',
        },
        ---LHS of extra mappings
        extra = {
            ---Add comment on the line above
            above = '<leader>cO',
            ---Add comment on the line below
            below = '<leader>co',
            ---Add comment at the end of line
            eol = '<leader>cA',
        },
        ---Enable keybindings
        ---NOTE: If given `false` then the plugin won't create any mappings
        mappings = {
            basic = true,
            extra = true,
        },
        ---Function to call before (un)comment
        pre_hook = nil,
        ---Function to call after (un)comment
        post_hook = nil,
    },
}
