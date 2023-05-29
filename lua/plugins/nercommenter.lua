return {
    -- commenting out code
    {
        'preservim/nerdcommenter',
        event = { 'BufEnter' },
        config = function()
            -- Create default mappings
            vim.g.NERDCreateDefaultMappings = 0

            -- Add spaces after comment delimiters by default
            vim.g.NERDSpaceDelims = 1

            -- Use compact syntax for prettified multi-line comments
            vim.g.NERDCompactSexyComs = 1

            -- Align line-wise comment delimiters flush left instead of following code indentation
            vim.g.NERDDefaultAlign = 'left'

            -- Set a language to use its alternate delimiters by default
            vim.g.NERDAltDelims_java = 1

            -- Allow commenting and inverting empty lines (useful when commenting a region)
            vim.g.NERDCommentEmptyLines = 1

            -- Enable trimming of trailing whitespace when uncommenting
            vim.g.NERDTrimTrailingWhitespace = 1

            -- Enable NERDCommenterToggle to check all selected lines is commented or not
            vim.g.NERDToggleCheckAllLines = 1

            local nmap = function(lhs, rhs, desc)
                if desc then
                    desc = "NerdCommenter: " .. desc
                end
                vim.keymap.set({ "n", "v" }, lhs, rhs, { silent = true, desc = desc })
            end

            -- mappings
            nmap("<leader>cc", "<Plug>NERDCommenterComment", "Comment")
            nmap("<leader>cu", "<Plug>NERDCommenterUncomment", "Uncomment")

            local commenterFixGrp = vim.api.nvim_create_augroup("CommenterFixGrp", { clear = true })
            vim.api.nvim_create_autocmd("BufEnter", {
                group = commenterFixGrp,
                pattern = "*",
                callback = function()
                    vim.opt.formatoptions:remove { 'c', 'r', 'o' }
                end,
                desc = "fix auto-commenting new line when entering insert mode e.g. with 'o'"
            })
        end
    }
}