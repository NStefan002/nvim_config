return {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    opts = {
        text = {
            spinner = "meter",
        },
        timer = {
            spinner_rate = 125,
        },
        window = {
            blend = 0,
            border = "double",
        },
    },
}
