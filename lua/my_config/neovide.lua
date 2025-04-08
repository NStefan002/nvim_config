if not vim.g.neovide then
    return
end

vim.opt.guicursor = "" -- block cursor
vim.g.neovide_opacity = 1
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_fullscreen = false
vim.g.neovide_confirm_quit = false
vim.g.neovide_profiler = false
vim.g.neovide_scale_factor = 1.0
local function change_scale_factor(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set("n", "<C-=>", function()
    change_scale_factor(1.25)
end, { desc = "Neovide: increase font size" })
vim.keymap.set("n", "<C-->", function()
    change_scale_factor(1 / 1.25)
end, { desc = "Neovide: decrease font size" })

local function toggle_fullscreen()
    vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
end
vim.keymap.set("n", "<C-`>", toggle_fullscreen, { desc = "Neovide: toggle fullscreen" })

local function change_opacity_factor(delta)
    if vim.g.neovide_opacity - delta <= 1 and vim.g.neovide_opacity - delta >= 0 then
        vim.g.neovide_opacity = vim.g.neovide_opacity - delta
    end
end

vim.keymap.set("n", "<A-T>", function()
    change_opacity_factor(-0.1)
end, { desc = "Neovide: decrease transparancy" })

vim.keymap.set("n", "<A-t>", function()
    change_opacity_factor(0.1)
end, { desc = "Neovide: increase transparancy" })

vim.g.neovide_cursor_animation_length = 0.11
vim.g.neovide_cursor_trail_size = 0.8
vim.g.neovide_cursor_animate_in_insert_mode = true
vim.g.neovide_cursor_animate_command_line = false
vim.g.neovide_cursor_unfocused_outline_width = 0.125
vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_cursor_vfx_opacity = 200.0
vim.g.neovide_cursor_vfx_particle_lifetime = 1.1
vim.g.neovide_cursor_vfx_particle_density = 99.0
vim.g.neovide_cursor_vfx_particle_speed = 7.0

vim.g.neovide_padding_top = 15
vim.g.neovide_padding_bottom = 15
vim.g.neovide_padding_right = 15
vim.g.neovide_padding_left = 15
