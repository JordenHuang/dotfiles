local lua_line = {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require("lualine").setup{
            options = {
                icons_enabled = true,
                theme = "catppuccin",
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                globalstatus = true,
            }
        }
    end
}


return {
    lua_line
}
