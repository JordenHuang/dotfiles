local which_key = {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 700
    end,
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    }
}


local nvim_telescope = {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },

    config = function()
        require("telescope").setup {
            defaults = {
                preview = {
                    filesize_limit = 20, -- MB
                },
            }
        }
    end
}


return {
    which_key,
    nvim_telescope
}
