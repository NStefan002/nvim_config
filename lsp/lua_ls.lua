return {
    settings = {
        Lua = {
            diagnostics = {
                globals = {
                    -- nvim <-> lua
                    "vim",
                    "assert",
                    "after_each",
                    "before_each",
                    "describe",
                    "it",
                    "pending",
                    -- awesome wm
                    "awesome",
                    "client",
                    "root",
                },
            },
            hint = {
                enable = true,
                arrayIndex = "Disable",
                paramName = "All",
                paramType = true,
            },
            telemetry = {
                enable = false,
            },
            workspace = {
                checkThirdParty = false,
            },
        },
    },
}
