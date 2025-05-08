return {
    settings = {
        organizeImports = false,
    },
    -- disable ruff as hover provider to avoid conflicts with basedpyright
    on_attach = function(client)
        client.server_capabilities.hoverProvider = false
    end,
}
