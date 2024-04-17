return {
    -- TODO: completely rewrite this bs
    dev = true,
    "NStefan002/mdmaker.nvim",
    cmd = "MdMake",
    opts = {
        enable_url_check = true,
        version_manager = { name = "bob", url = "https://github.com/MordechaiHadad/bob" },
        gui = { name = "Neovide", url = "https://neovide.dev/" },
        title = "",
    },
}
