if vim.g.neovide then
    vim.g.neovide_scale_factor = 1.0
    vim.g.neovide_transparency = 1
    vim.g.neovide_hide_mouse_when_typing = false
    vim.g.neovide_fullscreen = true
    vim.g.neovide_cursor_vfx_mode = "pixeldust"
    vim.g.neovide_cursor_vfx_mode = "sonicboom"
    vim.cmd.colorscheme("hybrid_reverse")
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none"} )
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"} )
end
