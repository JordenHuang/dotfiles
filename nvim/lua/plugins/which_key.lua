local which_key = {
    "folke/which-key.nvim",
    tag = "v2.1.0",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 1750
    end,
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    }
}






return {
    which_key
}
