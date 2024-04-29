require("my_config")

-- Lazy package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
    defaults = {
        lazy = true,
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                -- "netrwPlugin",
                "rplugin",
                "tarPlugin",
                -- "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
    install = {
        missing = false,
    },
    dev = {
        path = "~/repos",
    },
    ui = {
        border = "double",
        custom_keys = {
            ["<C-r>"] = {
                function(_)
                    ---@type LazyPlugin[]
                    local plugins = require("lazy.core.config").plugins
                    local file_content = {
                        "## 💤 Plugin manager",
                        "",
                        "- [lazy.nvim](https://github.com/folke/lazy.nvim)",
                        "",
                        "## 🔌 Plugins",
                        "",
                    }
                    local plugins_md = {}
                    for plugin, spec in pairs(plugins) do
                        if spec.url then
                            table.insert(
                                plugins_md,
                                ("- [%s](%s)"):format(plugin, spec.url:gsub("%.git$", ""))
                            )
                        end
                    end
                    table.sort(plugins_md, function(a, b)
                        return a:lower() < b:lower()
                    end)

                    for _, p in ipairs(plugins_md) do
                        table.insert(file_content, p)
                    end

                    table.insert(file_content, "")
                    table.insert(file_content, "## 🗃️ Version manager")
                    table.insert(file_content, "")
                    table.insert(file_content, "- [bob](https://github.com/MordechaiHadad/bob)")
                    table.insert(file_content, "")
                    table.insert(file_content, "## ✨ GUI")
                    table.insert(file_content, "")
                    table.insert(file_content, "- [Neovide](https://neovide.dev/)")

                    local file, err = io.open(vim.fn.stdpath("config") .. "/README.md", "w")
                    if not file then
                        error(err)
                    end
                    file:write(table.concat(file_content, "\n"))
                    file:close()
                end,
                desc = "Generate README.md file",
            },
        },
    },
})
