return {
    -- live server (like VSC extension)
    {
        "aurum77/live-server.nvim",
        lazy = true,
        build = function()
            require "live_server.util".install()
        end,
        cmd = { "LiveServer", "LiveServerStart", "LiveServerStop" },
    },
}
