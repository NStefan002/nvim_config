require("my_config.autocmds")
require("my_config.disable")
require("my_config.set")
require("my_config.remap")
require("my_config.neovide")

function P(name)
    print(vim.inspect(name))
end
