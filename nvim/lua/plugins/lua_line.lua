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
                -- theme = "catppuccin",
                -- component_separators = { left = '', right = '' },
                -- section_separators = { left = '', right = '' },
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                globalstatus = true, --(vim.o.laststatus == 3),
            },
            sections = {
                lualine_a = {
                    {
                        'mode',
                        separator = { right = ''}
                    },
                },
                lualine_b = {
                    {
                        'windows',
                        section_separators = { left = '', right = '' },
                        component_separators = { left = '|', right = '' },
                        filetype_names = { oil = 'Oil' }, 
                    },
                },
                lualine_c = {
                    {
                        'branch',
                        color = {fg='LightBlue'},
                    },
                    'diff', 'diagnostics'
                },
                lualine_x = {'encoding', 'filetype'},
                lualine_y = {'progress'},
                lualine_z = {'location'}
            }
        }
    end
}


return {
    lua_line
}
