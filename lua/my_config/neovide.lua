if vim.g.neovide then
    vim.opt.guicursor = "" -- block cursor
    vim.g.neovide_transparency = 1
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_fullscreen = false
    vim.g.neovide_confirm_quit = false
    vim.g.neovide_profiler = false
    vim.g.neovide_scale_factor = 1.0
    local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    vim.keymap.set("n", "<C-=>", function()
        change_scale_factor(1.25)
    end)
    vim.keymap.set("n", "<C-->", function()
        change_scale_factor(1 / 1.25)
    end)

    local toggle_fullscreen = function()
        vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
    end
    vim.keymap.set("n", "<C-`>", toggle_fullscreen)

    vim.g.neovide_cursor_animation_length = 0.11
    vim.g.neovide_cursor_trail_size = 0.8
    vim.g.neovide_cursor_animate_in_insert_mode = true
    vim.g.neovide_cursor_animate_command_line = true
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
end
