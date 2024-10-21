return {
    dev = true,
    "NStefan002/screenkey.nvim",
    lazy = false,
    version = "*",
    ---@module "screenkey"
    ---@type screenkey.config
    opts = {
        group_mappings = true,
        disable = {
            buftypes = { "terminal" },
        },
    },
}
