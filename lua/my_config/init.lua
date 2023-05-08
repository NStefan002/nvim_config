require("my_config.autocmds")
require("my_config.remap")
require("my_config.set")
require("my_config.neovide")

function R(name)
    require("plenary.reload").reload_module(name)
end
