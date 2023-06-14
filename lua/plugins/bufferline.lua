return {
    'akinsho/bufferline.nvim',
    event = { 'BufEnter' },
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require('bufferline').setup({})
    end
}
