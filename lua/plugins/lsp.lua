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
    { "gonstoll/wezterm-types", lazy = true }, -- wezterm types
    { "LuaCATS/luassert", name = "luassert-types", lazy = true },
    { "LuaCATS/busted", name = "busted-types", lazy = true },

    {
        "saghen/blink.cmp",
        version = "v0.*",
        lazy = false,
        dependencies = {
            "rafamadriz/friendly-snippets",
            "saghen/blink.compat",
        },
        build = "cargo build --release",
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

            -- Disables keymaps, completions and signature help for these filetypes
            blocked_filetypes = { "speedtyper" },

            completion = {
                trigger = {
                    show_on_x_blocked_trigger_characters = { "'", '"', "(", "{" },
                },

                menu = {
                    border = "double",
                    -- Controls how the completion items are rendered on the popup window
                    draw = {
                        -- Aligns the keyword you've typed to a component in the menu
                        align_to_component = "label", -- or 'none' to disable
                        -- Left and right padding, optionally { left, right } for different padding on each side
                        padding = 1,
                        -- Gap between columns
                        gap = 1,
                        -- Use treesitter to highlight the label text
                        treesitter = true,

                        -- Components to render, grouped by column
                        columns = {
                            { "label", "label_description", gap = 1 },
                            { "kind_icon", "kind", gap = 1 },
                        },
                    },
                },

                documentation = {
                    -- Controls whether the documentation window will automatically show when selecting a completion item
                    auto_show = true,
                    -- Delay before showing the documentation window
                    auto_show_delay_ms = 0,
                    -- Delay before updating the documentation window when selecting a new item,
                    -- while an existing item is still visible
                    update_delay_ms = 50,
                    -- Whether to use treesitter highlighting, disable if you run into performance issues
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
                completion = {
                    enabled_providers = function(_)
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
                },

                -- Please see https://github.com/Saghen/blink.compat for using `nvim-cmp` sources
                providers = {
                    lsp = {
                        name = "LSP",
                        module = "blink.cmp.sources.lsp",

                        enabled = true, -- Whether or not to enable the provider
                        transform_items = nil, -- Function to transform the items before they're returned
                        should_show_items = true, -- Whether or not to show the items
                        max_items = nil, -- Maximum number of items to display in the menu
                        min_keyword_length = 0, -- Minimum number of characters in the keyword to trigger the provider
                        fallback_for = {}, -- If any of these providers return 0 items, it will fallback to this provider
                        score_offset = 0, -- Boost/penalize the score of the items
                        override = nil, -- Override the source's functions
                    },
                    path = {
                        name = "Path",
                        module = "blink.cmp.sources.path",
                        min_keyword_length = 3,
                        score_offset = 3,
                        opts = {
                            show_hidden_files_by_default = true,
                        },
                    },
                    snippets = {
                        name = "Snippets",
                        module = "blink.cmp.sources.snippets",
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
                        name = "Buffer",
                        module = "blink.cmp.sources.buffer",
                        fallback_for = { "lsp" },
                        min_keyword_length = 4,
                    },
                },
            },
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
                    end, { "c" }),
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
                },
            })

            -- add some of the missing filetypes, that I need to work with (for university)
            vim.filetype.add({ extension = { pro = "prolog" } })
            vim.filetype.add({ extension = { ejs = "ejs" } })
        end,
    },
}
