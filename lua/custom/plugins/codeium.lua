return {
    -- similar to github copilot
    { 'Exafunction/codeium.vim',
        config = function()
            -- disable default bindings
            vim.g.codeium_disable_bindings = true

            local imap = function (lhs, rhs, desc)
                if desc then
                   desc = 'Codeium: ' .. desc
                end

                vim.keymap.set('i', lhs, rhs, { expr = true, desc = desc, silent = true })
            end

            imap( '<C-a>', function () return vim.fn['codeium#Accept']() end, "Accept" )
            imap( '<c-]>', function() return vim.fn['codeium#CycleCompletions'](1) end, "Cycle Forwards" )
            imap( '<c-[>', function() return vim.fn['codeium#CycleCompletions'](-1) end, "Cycle Backwards" )
            imap( '<c-x>', function() return vim.fn['codeium#Clear']() end, "Clear" )
            imap( '<c-g>', function() return vim.fn['codeium#Complete']() end, "Trigger Suggestions" )

            vim.keymap.set('n', '<leader>dcd', '<cmd>CodeiumDisable<CR>', {silent = false, desc = "Codeium: Disable"})
            vim.keymap.set('n', '<leader>ecd', '<cmd>CodeiumEnable<CR>', {silent = true, desc = "Codeium: Enable"})
        end
    }
}
