return {
    -- Language Server Protocol
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        lazy = false,
        -- event = { 'BufReadPre', 'BufNewFile', 'CmdlineEnter' },
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
                -- optional
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp', },        -- Required
            { 'hrsh7th/cmp-nvim-lsp' },     -- Required
            { 'hrsh7th/cmp-buffer' },       -- Optional
            { 'hrsh7th/cmp-path' },         -- Optional
            { 'saadparwaiz1/cmp_luasnip' }, -- Optional
            { 'hrsh7th/cmp-nvim-lua' },     -- Optional
            { 'hrsh7th/cmp-cmdline' },      -- Optional

            -- Snippets
            { 'L3MON4D3/LuaSnip' },             -- Required
            { 'rafamadriz/friendly-snippets' }, -- Optional

            -- additional lsp info
            { "folke/neodev.nvim" } -- Optional
        },
        config = function()
            local lsp = require('lsp-zero')

            lsp.preset("recommended")

            local mason_lspconfig = require("mason-lspconfig")
            mason_lspconfig.setup({
                ensure_installed = {
                    'lua_ls',
                    'clangd',
                    'rust_analyzer',
                    'tsserver',
                    'cssls',
                    'html',
                    'jsonls',
                    'bashls',
                }
            })

            -- Documentation for Neovim config in Lua
            require("neodev").setup()

            -- language servers
            local lspconfig = require("lspconfig")

            -- Fix Undefined global 'vim' (and preferably do not install more than 1
            -- language server per filetype)
            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' },
                        },
                        hint = {
                            enable = true,
                            arrayIndex = "Disable",
                            paramName = "All",
                            paramType = true
                        },
                        telemetry = {
                            enable = false
                        }
                    },
                },
            })
            lspconfig.clangd.setup({
                -- NOTE: see https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428
                capabilities = {
                    offsetEncoding = { "utf-16" },
                    clangdInlayHintsProvider = true
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
                    -- "--all-scopes-completion",
                    -- "--cross-file-rename",
                    "--log=info",
                    -- "--completion-style=detailed",
                    -- "--enable-config", -- clangd 11+ supports reading from .clangd configuration file
                    -- "--offset-encoding=utf-16",
                    "--header-insertion=never",
                },
            })
            lspconfig.rust_analyzer.setup({})
            lspconfig.tsserver.setup({
                settings = {
                    typescript = {
                        inlayHints = {
                            includeInlayParameterNameHints = 'all',
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayVariableTypeHints = false,
                            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayEnumMemberValueHints = true,
                        }
                    },
                    javascript = {
                        inlayHints = {
                            includeInlayParameterNameHints = 'all',
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayVariableTypeHints = false,
                            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayEnumMemberValueHints = true,
                        }
                    }
                }
            })
            lspconfig.html.setup({
                filetypes = { 'html', 'ejs' }
            })
            lspconfig.cssls.setup({})
            lspconfig.jsonls.setup({})
            lspconfig.bashls.setup({})


            local luasnip = require('luasnip')
            luasnip.config.setup {}

            -- Neovim by default does not recognize .ejs files (test with :echo &filetype)
            vim.filetype.add({ extension = { ejs = 'ejs' } })
            luasnip.filetype_set('ejs', { 'html', 'javascript', 'ejs' })

            -- My snippets and vscode snippets
            -- vim.o.runtimepath = vim.o.runtimepath..'~/.config/nvim/my_snippets/' NOTE: lsp-zero calls this line by default
            -- custom snippets are mostly taken from friendly-snippets and configured according to my needs
            -- check friendly-snippets at https://github.com/rafamadriz/friendly-snippets
            require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/my_snippets" })

            -- load all snippets except once that I have already configured in my_snippets directory
            require("luasnip.loaders.from_vscode").lazy_load({ exclude = { "c", "cpp" } })

            -- LuaSnip Snippet History Fix (Seems to work really well, I think.)
            local luasnip_fix_augroup = vim.api.nvim_create_augroup("LuaSnipHistory", { clear = true })
            vim.api.nvim_create_autocmd("ModeChanged", {
                pattern = '*',
                callback = function()
                    if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
                        and luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
                        and not luasnip.session.jump_active
                    then
                        luasnip.unlink_current()
                    end
                end,
                group = luasnip_fix_augroup
            })


            local cmp = require('cmp')

            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-Space>'] = cmp.mapping.complete({}),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    -- ['<Tab>'] = vim.NIL,
                    -- ['<S-Tab>'] = vim.NIL,
                }),
                preselect = 'item',
                completion = {
                    completeopt = 'menu,menuone,noinsert',
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                experimental = {
                    ghost_text = false,
                },
                sources = {
                    { name = 'luasnip' },
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lua' },
                    { name = 'path' },
                    { name = 'buffer',  keyword_length = 4 },
                }
            })

            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "cmdline" },
                    { name = "path" }
                },
                window = {
                    completion = cmp.config.window.bordered(),
                },
            })

            -- cmp.setup.cmdline({ '/', '?' }, {
            --     mapping = cmp.mapping.preset.cmdline(),
            -- sources = {
            --     { name = "buffer" }
            -- }
            -- })

            lsp.set_sign_icons {
                error = '',
                warn = '',
                hint = '',
                info = ''
            }

            lsp.on_attach(function(client, bufnr)
                -- BUG: lua_ls messes up comment highlights
                if client.name == "lua_ls" then
                    vim.api.nvim_set_hl(0, "@lsp.type.comment", {})
                end
                if client.server_capabilities.inlayHintProvider then
                    print('bultin inlay hints will be in nightly soon')
                    -- vim.lsp.buf.inlay_hint(bufnr, true)
                end
                -- function for shorter code
                local nmap = function(keys, func, desc, additionalMode)
                    if desc then
                        desc = 'LSP: ' .. desc
                    end
                    local mode
                    if additionalMode then
                        mode = { 'n', additionalMode }
                    else
                        mode = 'n'
                    end
                    vim.keymap.set(mode, keys, func, { buffer = bufnr, remap = false, desc = desc })
                end

                -- very useful
                nmap("<leader>f", function()
                    vim.lsp.buf.format({
                        async = true,
                        filter = function(cl)
                            return cl.name ~= "clangd"
                        end
                    })
                end, "[F]ormat File", 'v')
                nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
                nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
                nmap("K", vim.lsp.buf.hover, "Hover Documentation")
                nmap("<leader>of", vim.diagnostic.open_float, "[O]pen [F]loating window")
                nmap("[d", vim.diagnostic.goto_next, "Next Diagnostic")
                nmap("]d", vim.diagnostic.goto_prev, "Previous Diagnostic")
                nmap("ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
                nmap("gr", vim.lsp.buf.references, "[G]oto [R]eference")
                nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[N]ame", 'v')
                nmap("<C-k>", vim.lsp.buf.signature_help, "Help")
                nmap("<leader>ws", vim.lsp.buf.workspace_symbol, "[G]oto [D]efinition")
                nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
                nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
                nmap('<leader>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, '[W]orkspace [L]ist Folders')
            end)

            lsp.setup()

            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                update_in_insert = false,
                underline = true,
                severity_sort = true,
                float = {
                    focusable = false,
                    style = 'minimal',
                    border = 'rounded',
                    source = 'always',
                    header = '',
                    prefix = '',
                },
            })
        end
    },
    -- inlay hints
    {
        "lvimuser/lsp-inlayhints.nvim",
        branch = "anticonceal",
        -- lazy = false,
        event = "BufReadPre",
        opts = {
            inlay_hints = {
                parameter_hints = {
                    show = true,
                },
                type_hints = {
                    show = true,
                },
            }
        },
        config = function(_, opts)
            require("lsp-inlayhints").setup(opts)

            vim.keymap.set("n", "<leader>in", "<cmd>lua require('lsp-inlayhints').toggle()<CR>",
                { desc = "Lsp-[In]layhints Toggle" })

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
                callback = function(args)
                    if not (args.data and args.data.client_id) then
                        return
                    end
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    require("lsp-inlayhints").on_attach(client, args.buf)
                end,
            })
        end,
    },
}
