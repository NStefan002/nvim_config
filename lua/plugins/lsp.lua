return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        lazy = false,
        config = false,
        init = function()
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },

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

    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                "rafamadriz/friendly-snippets",
                "onsails/lspkind.nvim",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-cmdline",
            },
        },
        config = function()
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_cmp()

            local cmp = require("cmp")
            local cmp_action = lsp_zero.cmp_action()
            local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }

            local load_snippets = require("luasnip.loaders.from_vscode")
            load_snippets.lazy_load({
                paths = "~/.config/nvim/my_snippets",
            })
            load_snippets.lazy_load({
                exclude = { "c", "cpp" },
            })

            local preferred_sources = {
                { name = "luasnip" },
                { name = "nvim_lsp" },
                { name = "nvim_lua" },
                { name = "path" },
            }
            local function tooBig(bufnr)
                local max_filesize = 10 * 1024 -- 100 KB
                local check_stats = (vim.uv or vim.loop).fs_stat
                local ok, stats = pcall(check_stats, vim.api.nvim_buf_get_name(bufnr))
                if ok and stats and stats.size > max_filesize then
                    return true
                else
                    return false
                end
            end
            vim.api.nvim_create_autocmd("BufRead", {
                group = vim.api.nvim_create_augroup("CmpBufferDisableGrp", { clear = true }),
                callback = function(ev)
                    local sources = preferred_sources
                    if not tooBig(ev.buf) then
                        sources[#sources + 1] = { name = "buffer", keyword_length = 4 }
                    end
                    cmp.setup.buffer({
                        sources = cmp.config.sources(sources),
                    })
                end,
            })

            cmp.setup({
                mapping = {
                    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select_opts),
                    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select_opts),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete({}),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    ["<Tab>"] = cmp_action.luasnip_jump_forward(),
                    ["<S-Tab>"] = cmp_action.luasnip_jump_backward(),
                },
                preselect = "item",
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                formatting = {
                    fields = { "abbr", "kind", "menu" },
                    format = require("lspkind").cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50,
                        ellipsis_char = "...",
                    }),
                    expandable_indicator = true,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                experimental = {
                    ghost_text = false,
                },
                sources = cmp.config.sources({
                    { name = "luasnip" },
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "path" },
                    { name = "buffer", keyword_length = 4 },
                }),
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
            -- cmp.event:on("menu_opened", function()
            --     vim.b.copilot_suggestion_hidden = true
            -- end)
            --
            -- cmp.event:on("menu_closed", function()
            --     vim.b.copilot_suggestion_hidden = false
            -- end)
        end,
    },

    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "williamboman/mason-lspconfig.nvim" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "folke/neodev.nvim" },
        },
        config = function()
            -- This is where all the LSP shenanigans will live

            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(function(client, bufnr)
                if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint ~= nil then
                    vim.keymap.set("n", "<leader>in", function()
                        vim.lsp.inlay_hint.enable(bufnr, not vim.lsp.inlay_hint.is_enabled(bufnr)) -- toggle
                    end, { desc = "Lsp-[In]layhints Toggle", buffer = bufnr })
                    local inlay_hint_grp =
                        vim.api.nvim_create_augroup("InlayHintsInInsert", { clear = true })
                    vim.api.nvim_create_autocmd("InsertLeave", {
                        group = inlay_hint_grp,
                        pattern = "*",
                        callback = function()
                            vim.lsp.inlay_hint.enable(bufnr, false)
                        end,
                        desc = "Hide inlay hints",
                    })
                    vim.api.nvim_create_autocmd("InsertEnter", {
                        group = inlay_hint_grp,
                        pattern = "*",
                        callback = function()
                            vim.lsp.inlay_hint.enable(bufnr, true)
                        end,
                        desc = "Show inlay hints",
                    })
                end
                -- function for shorter code
                local nmap = function(keys, func, desc, additionalMode)
                    if desc then
                        desc = "LSP: " .. desc
                    end
                    local mode
                    if additionalMode then
                        mode = { "n", additionalMode }
                    else
                        mode = "n"
                    end
                    vim.keymap.set(mode, keys, func, { buffer = bufnr, remap = false, desc = desc })
                end

                nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
                nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
                nmap("K", vim.lsp.buf.hover, "Hover Documentation")
                nmap("<leader>of", vim.diagnostic.open_float, "[O]pen [F]loating window")
                nmap("]d", function()
                    vim.diagnostic.goto_next()
                    vim.cmd("normal zz")
                end, "Next diagnostic")
                nmap("[d", function()
                    vim.diagnostic.goto_prev()
                    vim.cmd("normal zz")
                end, "Previous diagnostic")
                nmap("]e", function()
                    vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
                    vim.cmd("normal zz")
                end, "Next error")
                nmap("[e", function()
                    vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
                    vim.cmd("normal zz")
                end, "Previous error")
                nmap("]w", function()
                    vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
                    vim.cmd("normal zz")
                end, "Next warning")
                nmap("[w", function()
                    vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
                    vim.cmd("normal zz")
                end, "Previous warning")
                nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
                nmap("gr", vim.lsp.buf.references, "[G]oto [R]eference")
                nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[N]ame", "v")
                nmap("H", vim.lsp.buf.signature_help, "Help")
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
            end)

            -- for versions <= 0.9.4
            lsp_zero.set_sign_icons({
                error = "",
                warn = "",
                hint = "",
                info = "",
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
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })

            require("neodev").setup({
                -- see https://github.com/rcarriga/nvim-dap-ui
                library = { plugins = { "nvim-dap-ui" }, types = true },
            })
            local lspconfig = require("lspconfig")
            local lspCapabilities = vim.lsp.protocol.make_client_capabilities()
            -- lspCapabilities.textDocument.completion.completionItem.snippetSupport = true
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "bashls",
                    "clangd",
                    "cssls",
                    "html",
                    "jsonls",
                    "lua_ls",
                    "rust_analyzer",
                    "tsserver",
                    "cmake",
                    "pyright",
                    "ruff_lsp",
                    "taplo",
                },
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        local nvim_lua_opts = lsp_zero.nvim_lua_ls()
                        local lua_opts = {
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = { "vim", "describe", "it", "assert" },
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
                        lspconfig.lua_ls.setup(vim.tbl_extend("force", nvim_lua_opts, lua_opts))
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
                    tsserver = function()
                        lspconfig.tsserver.setup({
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
                    pyright = function()
                        lspconfig.pyright.setup({
                            capabilities = lspCapabilities,
                        })
                    end,
                    taplo = function()
                        lspconfig.taplo.setup({
                            capabilities = lspCapabilities,
                        })
                    end,
                    ruff_lsp = function()
                        lspconfig.ruff_lsp.setup({
                            settings = {
                                organizeImports = false,
                            },
                            -- disable ruff as hover provider to avoid conflicts with pyright
                            on_attach = function(client)
                                client.server_capabilities.hoverProvider = false
                            end,
                        })
                    end,
                },
            })

            local luasnip = require("luasnip")
            -- Neovim by default does not recognize .ejs files (test with :echo &filetype)
            vim.filetype.add({ extension = { ejs = "ejs" } })
            luasnip.filetype_set("ejs", { "html", "javascript", "ejs" })

            local luasnip_fix_augroup =
                vim.api.nvim_create_augroup("LuaSnipHistory", { clear = true })
            vim.api.nvim_create_autocmd("ModeChanged", {
                pattern = "*",
                callback = function()
                    if
                        (
                            (vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n")
                            or vim.v.event.old_mode == "i"
                        )
                        and luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
                        and not luasnip.session.jump_active
                    then
                        luasnip.unlink_current()
                    end
                end,
                group = luasnip_fix_augroup,
            })
        end,
    },
}
