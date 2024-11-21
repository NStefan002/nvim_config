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
    { "Bilal2453/luvit-meta", lazy = true }, -- `vim.uv` types
    { "justinsgithub/wezterm-types", lazy = true }, -- wezterm types
    { "LuaCATS/luassert", name = "luassert-types", lazy = true },
    { "LuaCATS/busted", name = "busted-types", lazy = true },

    {
        "saghen/blink.cmp",
        lazy = false,
        dependencies = { { "rafamadriz/friendly-snippets" }, { "saghen/blink.compat" } },
        version = "v0.*",
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
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
            },

            accept = {
                create_undo_point = true,
                auto_brackets = { enabled = false },
            },

            trigger = {
                signature_help = {
                    enabled = true,
                    -- when true, will show the signature help window when the cursor comes after a trigger character when entering insert mode
                    show_on_insert_on_trigger_character = true,
                },
            },

            fuzzy = {
                -- frencency tracks the most recently/frequently used items and boosts the score of the item
                use_frecency = true,
                -- proximity bonus boosts the score of items matching nearby words
                use_proximity = true,
                max_items = 200,
                -- controls which sorts to use and in which order, these three are currently the only allowed options
                sorts = { "label", "kind", "score" },

                prebuilt_binaries = {
                    -- Whether or not to automatically download a prebuilt binary from github. If this is set to `false`
                    -- you will need to manually build the fuzzy binary dependencies by running `cargo build --release`
                    download = true,
                    -- When downloading a prebuilt binary, force the downloader to resolve this version. If this is unset
                    -- then the downloader will attempt to infer the version from the checked out git tag (if any).
                    --
                    -- Beware that if the FFI ABI changes while tracking main then this may result in blink breaking.
                    force_version = nil,
                    -- When downloading a prebuilt binary, force the downloader to use this system triple. If this is unset
                    -- then the downloader will attempt to infer the system triple from `jit.os` and `jit.arch`.
                    -- Check the latest release for all available system triples
                    --
                    -- Beware that if the FFI ABI changes while tracking main then this may result in blink breaking.
                    force_system_triple = nil,
                },
            },

            sources = {
                -- list of enabled providers
                completion = {
                    enabled_providers = { "lsp", "path", "snippets", "buffer" },
                },

                providers = {
                    -- snippets = {
                    --     name = "Snippets",
                    --     module = "blink.cmp.sources.snippets",
                    --     score_offset = -3,
                    --     opts = {
                    --         friendly_snippets = true,
                    --         search_paths = { vim.fn.stdpath("config") .. "/my_snippets" },
                    --         global_snippets = { "all" },
                    --         extended_filetypes = {},
                    --         ignored_filetypes = {},
                    --     },
                    -- },
                },
            },

            windows = {
                autocomplete = {
                    border = "double",
                    -- keep the cursor X lines away from the top/bottom of the window
                    scrolloff = 2,
                    -- Controls how the completion items are selected
                    -- 'preselect' will automatically select the first item in the completion list
                    -- 'manual' will not select any item by default
                    -- 'auto_insert' will not select any item by default, and insert the completion items automatically when selecting them
                    selection = "preselect",
                    -- Controls how the completion items are rendered on the popup window
                    -- 'simple' will render the item's kind icon the left alongside the label
                    -- 'reversed' will render the label on the left and the kind icon + name on the right
                    -- 'minimal' will render the label on the left and the kind name on the right
                    -- 'function(blink.cmp.CompletionRenderContext): blink.cmp.Component[]' for custom rendering
                    draw = "reversed",
                    -- Controls the cycling behavior when reaching the beginning or end of the completion list.
                    cycle = {
                        -- When `true`, calling `select_next` at the *bottom* of the completion list will select the *first* completion item.
                        from_bottom = true,
                        -- When `true`, calling `select_prev` at the *top* of the completion list will select the *last* completion item.
                        from_top = true,
                    },
                },
                documentation = {
                    border = "single",
                    auto_show = true,
                    auto_show_delay_ms = 0,
                    update_delay_ms = 50,
                },
                signature_help = {
                    border = "rounded",
                },
                ghost_text = {
                    enabled = false,
                },
            },

            -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- adjusts spacing to ensure icons are aligned
            nerd_font_variant = "mono",

            -- don't show completions or signature help for these filetypes. Keymaps are also disabled.
            blocked_filetypes = {},
        },
    },

    -- use this for cmdline completion until blink implements it
    {
        "hrsh7th/nvim-cmp",
        lazy = false,
        dependencies = {
            {
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline",
            },
        },
        config = function()
            local cmp = require("cmp")
            local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                preselect = "item",
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                formatting = {
                    fields = { "abbr", "kind", "menu" },
                },
                window = {
                    completion = cmp.config.window.bordered(),
                },
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline({
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            local entry = cmp.get_selected_entry()
                            if not entry then
                                cmp.select_next_item({ cmp_select_opts })
                            else
                                cmp.confirm()
                            end
                        else
                            fallback()
                        end
                    end, { "i", "s", "c" }),
                }),
                sources = cmp.config.sources({
                    { name = "cmdline" },
                    { name = "path" },
                }),
                window = {
                    completion = cmp.config.window.bordered(),
                },
            })

            local grp = vim.api.nvim_create_augroup("CmpCmdlineToggle", {})
            vim.api.nvim_create_autocmd("CmdlineEnter", {
                group = grp,
                callback = function()
                    cmp.setup({ enabled = true })
                end,
                desc = "Enable cmp when entering cmdline",
            })
            vim.api.nvim_create_autocmd("CmdlineLeave", {
                group = grp,
                callback = function()
                    cmp.setup({ enabled = false })
                end,
                desc = "Disable cmp when leaving cmdline",
            })
        end,
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
                                vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
                            end,
                            desc = "Hide inlay hints",
                        })
                        vim.api.nvim_create_autocmd("InsertEnter", {
                            group = inlay_hint_grp,
                            pattern = "*",
                            callback = function()
                                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
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
                },
            })

            -- add some of the missing filetypes, that I need to work with (for university)
            vim.filetype.add({ extension = { pro = "prolog" } })
            vim.filetype.add({ extension = { ejs = "ejs" } })
        end,
    },
}
