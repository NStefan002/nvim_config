return {
    capabilities = {
        offsetEncoding = { "utf-16" },
        clangdInlayHintsProvider = true,
    },
    setting = {
        InlayHints = {
            Enabled = true,
            ParameterNames = true,
            DeducedTypes = true,
        },
    },
    cmd = {
        "clangd",
        "--suggest-missing-includes",
        "--header-insertion-decorators",
        "--all-scopes-completion",
        "--cross-file-rename",
        "--log=info",
        "--completion-style=detailed",
        -- "--enable-config", -- clangd 11+ supports reading from .clangd configuration file
        -- "--offset-encoding=utf-16",
        "--header-insertion=never",
    },
}
