local lsp = require('lsp-zero')

lsp.preset("recommended")

lsp.ensure_installed({
    'tsserver',
    'lua_ls',
    'rust_analyzer',
    'clangd',
})

-- Documentation for Neovim config in Lua
require("neodev").setup()

-- Fix Undefined global 'vim' (and preferably do not install more than 1
-- language server per filetype)
lsp.configure('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
            completion = {
                callSnippet = "Replace"
            },
        },
    },
})

-- My snippets and vscode snippets
-- vim.o.runtimepath = vim.o.runtimepath..'/home/nstefan002/.config/nvim/my_snippets/'
require("luasnip.loaders.from_vscode").lazy_load({paths = "~/.config/nvim/my_snippets"})


local luasnip = require('luasnip')
luasnip.config.setup {}
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete({}),
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
})


lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = '',
        warn = '',
        hint = '',
        info = ''
    }
})

-- lsp.on_attach(function(client, bufnr)
--     local opts = { buffer = bufnr, remap = false }
--
--     -- very useful
--     vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts, { desc = "[G]oto [D]efinition" })
--     vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts, { desc = "[G]oto [D]eclaration" })
--     vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts, { desc = "Hover Documentation" })
--     vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts, { desc = "[G]oto [D]efinition" })
--     vim.keymap.set("n", "<leader>of", function() vim.diagnostic.open_float() end, opts, { desc = "[O]pen [F]loating window" })
--     vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts, { desc = "Next Diagnostic" })
--     vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts, { desc = "Previous Diagnostic" })
--     vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts, { desc = "[C]ode [A]ction" })
--     vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.references() end, opts, { desc = "[G]oto [R]eference" })
--     vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts, { desc = "[R]e[N]ame" })
--     vim.keymap.set("n", "<C-k>", function() vim.lsp.buf.signature_help() end, opts, { desc = "Help" })
-- end)

lsp.setup()

-- function for shorter code
local nmap = function(keys, func, desc)
    if desc then
        desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
end

nmap("<leader>f", vim.lsp.buf.format, "[F]ormat File")
nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
nmap("K", vim.lsp.buf.hover, "Hover Documentation")
nmap("<leader>of", vim.diagnostic.open_float, "[O]pen [F]loating window")
nmap("[d", vim.diagnostic.goto_next, "Next Diagnostic")
nmap("]d", vim.diagnostic.goto_prev, "Previous Diagnostic")
nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
nmap("<leader>gr", vim.lsp.buf.references, "[G]oto [R]eference")
nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[N]ame")
nmap("<C-k>", vim.lsp.buf.signature_help, "Help")
nmap("<leader>ws", vim.lsp.buf.workspace_symbol, "[G]oto [D]efinition")
nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, '[W]orkspace [L]ist Folders')


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
