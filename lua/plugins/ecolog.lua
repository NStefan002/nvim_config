return {
    "philosofonusus/ecolog.nvim",
    lazy = false,
    opts = {
        integrations = {
            blink_cmp = true,
            fzf = {
                shelter = {
                    mask_on_copy = false,
                },
                mappings = {
                    copy_value = "enter",
                    copy_name = "ctrl-y",
                    edit_var = "ctrl-e",
                },
            },
        },
        shelter = {
            modules = {
                files = true,
                fzf = true,
                fzf_previewer = true,
            },
        },
        path = vim.fn.getcwd(),
    },
}
