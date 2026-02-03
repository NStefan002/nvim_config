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
        version = "v1.*",
        lazy = false,
        dependencies = {
            "rafamadriz/friendly-snippets",
            "saghen/blink.compat",
            "echasnovski/mini.icons",
        },
        build = "cargo build --release",
        opts = {
            keymap = {
                ["<c-space>"] = { "show", "show_documentation", "hide_documentation" },
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

            -- Enables keymaps, completions and signature help when true
            enabled = function()
                return vim.bo.buftype ~= "prompt"
                    and not vim.tbl_contains({ "DressingInput" }, vim.bo.filetype) -- add more filetypes if needed
                    and vim.b.completion ~= false
            end,

            completion = {
                list = {
                    selection = {
                        preselect = function(ctx)
                            return ctx.mode ~= "cmdline"
                                and not require("blink.cmp").snippet_active({ direction = 1 })
                        end,
                        auto_insert = function(ctx)
                            return ctx.mode == "cmdline"
                        end,
                    },
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
                    border = "single",
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
                        return { "lazydev", "lsp", "path", "snippets", "buffer" }
                    end
                end,

                -- You may also define providers per filetype
                per_filetype = {
                    oil = {},
                },

                min_keyword_length = 0,

                -- Please see https://github.com/Saghen/blink.compat for using `nvim-cmp` sources
                providers = {
                    lsp = {
                        min_keyword_length = 0,
                        score_offset = 3,
                    },
                    path = {
                        score_offset = 3,
                        min_keyword_length = 3,
                        opts = {
                            show_hidden_files_by_default = true,
                        },
                    },
                    snippets = {
                        min_keyword_length = 2,
                        score_offset = 4,
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
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        -- make lazydev completions top priority (see `:h blink.cmp`)
                        score_offset = 100,
                    },
                    ecolog = { name = "ecolog", module = "ecolog.integrations.cmp.blink_cmp" },
                },
            },

            -- override options for cmdline and terminal modes
            cmdline = {
                keymap = {
                    ["<c-e>"] = { "show" },
                    ["<c-x>"] = { "hide" },
                    ["<tab>"] = { "select_and_accept" },

                    ["<c-p>"] = { "select_prev" },
                    ["<c-n>"] = { "select_next" },
                },

                sources = function()
                    local type = vim.fn.getcmdtype()
                    if type == ":" or type == "@" then
                        return { "cmdline" }
                    end
                    return {}
                end,

                completion = {
                    menu = { auto_show = true },
                },
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspStart", "LspStop", "LspLog", "MasonInstallAll" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            {
                -- used only to automatically call `vim.lsp.enable()` for all installed LSPs
                "mason-org/mason-lspconfig.nvim",
                opts = {
                    automatic_enable = {
                        exclude = {
                            "harper_ls",
                        },
                    },
                },
            },
            {
                "williamboman/mason.nvim",
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
                    focusable = true,
                    style = "minimal",
                    border = "rounded",
                    source = true,
                    header = "",
                    prefix = "",
                },
            })

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

            -- add some of the missing filetypes, that I need to work with (for university)
            vim.filetype.add({ extension = { pro = "prolog" } })
            vim.filetype.add({ extension = { ejs = "ejs" } })
        end,
    },
    {
        "R-nvim/R.nvim",
        lazy = false,
        config = function()
            ---@type RConfigUserOpts
            local opts = {
                hook = {
                    on_filetype = function()
                        vim.keymap.set("n", "<enter>", "<Plug>RDSendLine", { buffer = true })
                        vim.keymap.set("v", "<enter>", "<Plug>RSendSelection", { buffer = true })
                    end,
                },
                R_args = { "--quiet", "--no-save" },
                min_editor_width = 72,
                rconsole_width = 78,
                objbr_mappings = { -- Object browser keymap
                    c = "class", -- Call R functions
                    ["<localleader>gg"] = "head({object}, n = 15)", -- Use {object} notation to write arbitrary R code.
                    v = function()
                        -- Run lua functions
                        require("r.browser").toggle_view()
                    end,
                },
                disable_cmds = {
                    -- "RClearConsole",
                    "RCustomStart",
                    -- "RSPlot",
                    "RSaveClose",
                },
            }
            -- Check if the environment variable "R_AUTO_START" exists.
            -- If using fish shell, you could put in your config.fish:
            -- alias r "R_AUTO_START=true nvim"
            if vim.env.R_AUTO_START == "true" then
                opts.auto_start = "on startup"
                opts.objbr_auto_start = true
            end
            require("r").setup(opts)
        end,
    },
    {
        "pmizio/typescript-tools.nvim",
        lazy = false,
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {},
    },
}
