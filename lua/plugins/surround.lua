return {
    "echasnovski/mini.surround",
    version = "*",
    event = "BufEnter",
    opts = {
        mappings = {
            add = "sa", -- Add surrounding in Normal and Visual modes
            delete = "sd", -- Delete surrounding
            find = "sf", -- Find surrounding (to the right)
            find_left = "sF", -- Find surrounding (to the left)
            highlight = "", -- Highlight surrounding
            replace = "sr", -- Replace surrounding
            update_n_lines = "", -- Update `n_lines`

            suffix_last = "", -- Suffix to search with "prev" method
            suffix_next = "", -- Suffix to search with "next" method
        },
        -- Whether to respect selection type:
        -- - Place surroundings on separate lines in linewise mode.
        -- - Place surroundings on each line in blockwise mode.
        respect_selection_type = false,

        -- How to search for surrounding (first inside current line, then inside
        -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
        -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
        -- see `:h MiniSurround.config`.
        search_method = "cover",

        -- Whether to disable showing non-error feedback
        silent = false,
    },
}
