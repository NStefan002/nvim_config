return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "luvit-meta/library", words = { "vim%.uv" } },
                { path = "wezterm-types", mods = { "wezterm" } },
                { path = "luassert-types/library", words = { "assert" } },
                { path = "busted-types/library", words = { "describe" } },
            },
        },
    },
    { "Bilal2453/luvit-meta" }, -- `vim.uv` types
    { "gonstoll/wezterm-types" }, -- wezterm types
    { "LuaCATS/luassert", name = "luassert-types" },
    { "LuaCATS/busted", name = "busted-types" },

    {
        "saghen/blink.cmp",
        version = "v0.*",
        lazy = false,
        dependencies = {
            "rafamadriz/friendly-snippets",
            "saghen/blink.compat",
            "echasnovski/mini.icons",
        },
        build = "cargo build --release",
        opts = {
            keymap = {
                ["<c-e>"] = { "show", "show_documentation", "hide_documentation" },
                ["<c-x>"] = { "hide" },
                ["<c-y>"] = { "select_and_accept" },
                ["<cr>"] = { "select_and_accept", "fallback" },

                ["<c-p>"] = { "select_prev", "fallback" },
                ["<c-n>"] = { "select_next", "fallback" },

                ["<c-u>"] = { "scroll_documentation_up", "fallback" },
                ["<c-d>"] = { "scroll_documentation_down", "fallback" },

                ["<tab>"] = { "snippet_forward", "fallback" },
                ["<s-tab>"] = { "snippet_backward", "fallback" },

                cmdline = {
                    ["<c-e>"] = { "show" },
                    ["<c-x>"] = { "hide" },
                    ["<tab>"] = { "select_and_accept" },

                    ["<c-p>"] = { "select_prev" },
                    ["<c-n>"] = { "select_next" },
                },
            },

            -- Enables keymaps, completions and signature help when true
            enabled = function()
                return vim.bo.buftype ~= "prompt"
                    and not vim.tbl_contains({ "DressingInput" }, vim.bo.filetype) -- add more filetypes if needed
                    and vim.b.completion ~= false
            end,

            completion = {
                list = {
                    selection = function(ctx)
                        return ctx.mode == "cmdline" and "auto_insert" or "preselect"
                    end,
                },

                trigger = {
                    show_on_trigger_character = true,
                    show_on_x_blocked_trigger_characters = { "'", '"', "(", "{" },
                },

                accept = {
                    auto_brackets = {
                        enabled = false,
                    },
                },

                menu = {
                    border = "double",
                    auto_show = true,
                    draw = {
                        align_to = "label", -- or 'none' to disable, or 'cursor' to align to the cursor
                        padding = 1,
                        gap = 1,
                        -- Use treesitter to highlight the label text
                        treesitter = { "lsp" },
                        -- Components to render, grouped by column
                        columns = {
                            { "label", "label_description", gap = 1 },
                            { "kind_icon", "kind", gap = 1 },
                        },
                        -- use mini.icons when drawing blink.cmp components
                        components = {
                            kind_icon = {
                                ellipsis = false,
                                text = function(ctx)
                                    local kind_icon, _, _ =
                                        require("mini.icons").get("lsp", ctx.kind)
                                    return kind_icon
                                end,
                                -- Optionally, you may also use the highlights from mini.icons
                                highlight = function(ctx)
                                    local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                                    return hl
                                end,
                            },
                        },
                    },
                },

                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 0,
                    treesitter_highlighting = true,
                    window = {
                        border = "single",
                    },
                },

                ghost_text = {
                    enabled = false,
                },
            },

            -- Experimental signature help support
            signature = {
                enabled = true,
                window = {
                    border = "padded",
                    -- Disable if you run into performance issues
                    treesitter_highlighting = true,
                },
            },

            sources = {
                default = function()
                    local ok, node = pcall(vim.treesitter.get_node)
                    if
                        ok
                        and node
                        and vim.tbl_contains(
                            { "comment", "line_comment", "block_comment" },
                            node:type()
                        )
                    then
                        return { "buffer", "path" }
                    else
                        return { "lsp", "path", "snippets", "buffer" }
                    end
                end,

                -- You may also define providers per filetype
                per_filetype = {
                    -- lua = { 'lsp', 'path' },
                    oil = {},
                },

                cmdline = function()
                    if vim.fn.getcmdtype() == ":" then
                        return { "cmdline" }
                    end
                    return {}
                end,

                min_keyword_length = 0,

                -- Please see https://github.com/Saghen/blink.compat for using `nvim-cmp` sources
                providers = {
                    path = {
                        score_offset = 3,
                        min_keyword_length = 3,
                        opts = {
                            show_hidden_files_by_default = true,
                        },
                    },
                    snippets = {
                        score_offset = -3,
                        opts = {
                            friendly_snippets = true,
                            search_paths = { vim.fn.stdpath("config") .. "/snippets" },
                            global_snippets = { "all" },
                            extended_filetypes = { "c", "cpp", "ejs" },
                            ignored_filetypes = {},
                        },
                    },
                    buffer = {
                        min_keyword_length = 4,
                    },
                },
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart", "MasonInstallAll" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "williamboman/mason-lspconfig.nvim" },
            {
                "williamboman/mason.nvim",
                lazy = false,
                opts = {
                    registries = {
                        "github:nvim-java/mason-registry",
                        "github:mason-org/mason-registry",
                    },
                },
            },
        },
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP stuff",
                callback = function(ev)
                    local bufnr = ev.buf

                    ---function for shorter code
                    ---@param keys string
                    ---@param func string | fun()
                    ---@param desc? string
                    local function nmap(keys, func, desc)
                        if desc then
                            desc = "LSP: " .. desc
                        end
                        vim.keymap.set(
                            "n",
                            keys,
                            func,
                            { buffer = bufnr, remap = false, desc = desc }
                        )
                    end

                    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
                    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
                    nmap("K", function()
                        vim.lsp.buf.hover({ border = "single" })
                    end, "Hover Documentation")
                    nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
                    nmap("gr", vim.lsp.buf.references, "[G]oto [R]eference")
                    nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[N]ame")
                    nmap("<leader>ws", vim.lsp.buf.workspace_symbol, "[G]oto [D]efinition")
                    nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
                    nmap(
                        "<leader>wr",
                        vim.lsp.buf.remove_workspace_folder,
                        "[W]orkspace [R]emove Folder"
                    )
                    nmap("<leader>wl", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, "[W]orkspace [L]ist Folders")

                    vim.keymap.set(
                        "i",
                        "<c-k>",
                        vim.lsp.buf.signature_help,
                        { desc = "Show function signature" }
                    )

                    local id = vim.tbl_get(ev, "data", "client_id")
                    local client = id and vim.lsp.get_client_by_id(id)
                    if client == nil then
                        return
                    end

                    if
                        client.server_capabilities.inlayHintProvider
                        and vim.lsp.inlay_hint ~= nil
                    then
                        vim.keymap.set("n", "<leader>in", function()
                            vim.lsp.inlay_hint.enable(
                                not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
                                { bufnr = bufnr }
                            ) -- toggle
                        end, {
                            desc = "Lsp-[In]layhints Toggle",
                            buffer = bufnr,
                        })
                        local inlay_hint_grp = vim.api.nvim_create_augroup("InlayHintsInInsert", {})
                        vim.api.nvim_create_autocmd("InsertLeave", {
                            group = inlay_hint_grp,
                            pattern = "*",
                            callback = function()
                                pcall(vim.lsp.inlay_hint.enable, false, { bufnr = bufnr })
                            end,
                            desc = "Hide inlay hints",
                        })
                        vim.api.nvim_create_autocmd("InsertEnter", {
                            group = inlay_hint_grp,
                            pattern = "*",
                            callback = function()
                                pcall(vim.lsp.inlay_hint.enable, true, { bufnr = bufnr })
                            end,
                            desc = "Show inlay hints",
                        })
                    end
                end,
            })

            vim.diagnostic.config({
                virtual_text = true,
                -- for nightly builds
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "",
                        [vim.diagnostic.severity.WARN] = "",
                        [vim.diagnostic.severity.INFO] = "",
                        [vim.diagnostic.severity.HINT] = "",
                    },
                    numhl = {
                        [vim.diagnostic.severity.ERROR] = "DiagnosticError",
                        [vim.diagnostic.severity.WARN] = "DiagnosticWarning",
                        [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
                        [vim.diagnostic.severity.HINT] = "DiagnosticHint",
                    },
                },
                update_in_insert = false,
                underline = false,
                severity_sort = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = true,
                    header = "",
                    prefix = "",
                },
            })

            local lspconfig = require("lspconfig")
            local lspconfig_defaults = lspconfig.util.default_config
            lspconfig_defaults.capabilities = vim.tbl_deep_extend(
                "force",
                lspconfig_defaults.capabilities,
                require("blink.cmp").get_lsp_capabilities()
            )
            vim.api.nvim_create_user_command("MasonInstallAll", function()
                local ensure_installed = {
                    "basedpyright",
                    "bash-language-server",
                    "beautysh",
                    "black",
                    "clang-format",
                    "clangd",
                    "cmake-language-server",
                    "cpptools",
                    "cspell",
                    "css-lsp",
                    "debugpy",
                    "goimports",
                    "golangci-lint",
                    "gopls",
                    "haskell-language-server",
                    "html-lsp",
                    "isort",
                    "json-lsp",
                    "lua-language-server",
                    "luacheck",
                    "markdownlint",
                    "prettier",
                    "prettierd",
                    "pyright",
                    "ruff",
                    "stylua",
                    "taplo",
                    "templ",
                    "typescript-language-server",
                }

                vim.cmd(string.format("MasonInstall %s", table.concat(ensure_installed, " ")))
            end, {
                nargs = 0,
                desc = "Install all tools specified in the ensure_installed list.",
            })

            require("mason-lspconfig").setup({
                handlers = {
                    -- default handler
                    function(server_name)
                        lspconfig[server_name].setup({
                            on_attach = function(client)
                                -- disable semantic highlights
                                -- client.server_capabilities.semanticTokensProvider = nil
                                -- disable formatting capabilities (formatting is done by conform.nvim)
                                client.server_capabilities.documentFormattingProvider = false
                                client.server_capabilities.documentFormattingRangeProvider = false
                            end,
                        })
                    end,
                    lua_ls = function()
                        lspconfig.lua_ls.setup({
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
                        })
                    end,
                    clangd = function()
                        lspconfig.clangd.setup({
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
                        })
                    end,
                    ts_ls = function()
                        lspconfig.ts_ls.setup({
                            settings = {
                                typescript = {
                                    inlayHints = {
                                        includeInlayParameterNameHints = "all",
                                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                        includeInlayFunctionParameterTypeHints = true,
                                        includeInlayVariableTypeHints = false,
                                        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                                        includeInlayPropertyDeclarationTypeHints = true,
                                        includeInlayFunctionLikeReturnTypeHints = true,
                                        includeInlayEnumMemberValueHints = true,
                                    },
                                },
                                javascript = {
                                    inlayHints = {
                                        includeInlayParameterNameHints = "all",
                                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                        includeInlayFunctionParameterTypeHints = true,
                                        includeInlayVariableTypeHints = false,
                                        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                                        includeInlayPropertyDeclarationTypeHints = true,
                                        includeInlayFunctionLikeReturnTypeHints = true,
                                        includeInlayEnumMemberValueHints = true,
                                    },
                                },
                            },
                        })
                    end,
                    html = function()
                        lspconfig.html.setup({
                            filetypes = { "html", "ejs" },
                        })
                    end,
                    basedpyright = function()
                        lspconfig.basedpyright.setup({
                            filetypes = { "python" },
                        })
                    end,
                    ruff = function()
                        lspconfig.ruff.setup({
                            settings = {
                                organizeImports = false,
                            },
                            -- disable ruff as hover provider to avoid conflicts with basedpyright
                            on_attach = function(client)
                                client.server_capabilities.hoverProvider = false
                            end,
                        })
                    end,
                    harper_ls = function()
                        lspconfig.harper_ls.setup({
                            autostart = false,
                        })
                    end,
                },
            })

            -- add some of the missing filetypes, that I need to work with (for university)
            vim.filetype.add({ extension = { pro = "prolog" } })
            vim.filetype.add({ extension = { ejs = "ejs" } })
        end,
    },
}
