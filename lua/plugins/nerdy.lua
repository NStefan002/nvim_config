return {
    "2kabhishek/nerdy.nvim",
    build = "python3 scripts/generator.py",
    dependencies = {
        "folke/snacks.nvim",
    },
    opts = {
        use_new_command = true,
        add_default_keybindings = false,
        copy_to_clipboard = true,
    },
    cmd = "Nerdy",
}
