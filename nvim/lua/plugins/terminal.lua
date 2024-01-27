local nvim_toggleterm = {
    'akinsho/toggleterm.nvim', version = "*",
    opts = {
        --[[ things you want to change go here]]
    },

    config = function()
        require("toggleterm").setup({
            size = 12,
            open_mapping = "<leader>m",
            insert_mappings = false,
            hide_numbers = true,

            -- make terminal background darker
            shade_terminals = true,
            shading_factor = 1,

            start_in_insert = true,
            direction = "horizontal",
            shell = vim.o.shell,
            float_opts = {
                border = "curved",
                winblend = 0,
                highlights = {
                    border = "Normal",
                    background = "Normal",
                },
            },
        })
    end,
}


return{
    nvim_toggleterm
}
