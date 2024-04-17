return {
    { dev = true, "NStefan002/2048.nvim", cmd = "Play2048", config = true },
    {
        dev = true,
        dir = "NStefan002/15puzzle.nvim/",
        cmd = "Play15puzzle",
        config = true,
    },
    {
        dev = true,
        "NStefan002/donut.nvim",
        event = "VeryLazy",
        opts = {
            timeout = 600,
        },
    },
    {
        dev = true,
        "letieu/hacker.nvim",
        cmd = { "Hack", "HackAuto", "HackFollow", "HackFollowAuto" },
        config = true,
    },
    {
        "seandewar/killersheep.nvim",
        cmd = "KillKillKill",
        config = true,
    },
    {
        "willothy/strat-hero.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        cmd = "StratHero",
        config = true,
    },
}
