local lua_line = {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local function show_time()
            return " " .. os.date("%H:%M")
        end

        require("lualine").setup{
            options = {
                icons_enabled = true,
                theme = "catppuccin",
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                globalstatus = true,
            },
            sections = {
                lualine_a = {
                    {
                        'mode',
                        separator = { right = ''}
                    },
                    {
                        'windows',
                        section_separators = { left = '', right = '' },
                        component_separators = { left = '|', right = '' },
                        filetype_names = { oil = 'Oil' }, 
                        use_mode_colors = false,
                    },
                },
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = {},
                lualine_x = {'encoding', 'fileformat', 'filetype'},
                lualine_y = {'progress'},
                lualine_z = {'location', show_time}
            }
        }
    end
}


return {
    lua_line
}
