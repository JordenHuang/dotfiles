local catppuccin_theme = {
    "catppuccin/nvim", name = "catppuccin", priority = 1000,
    config = function()
        require("catppuccin").setup {
            flavour = "auto", -- latte, frappe, macchiato, mocha
            background = { -- :h background
                light = "latte",
                dark = "frappe",
            },
            color_overrides = {
                all = {
                },
                latte = {
                    text = "#000000",
                    base = "#fbfbfb",
                    mantle = "#ededed",
                    crust = "#d0d0d0",
                    blue = "#6390e9",
                },
                -- frappe = {}, -- this is a good colorscheme
                -- macchiato = {},
                -- mocha = {},
            },

            custom_highlights = function(colors)
                local u = require("catppuccin.utils.colors")
                return{
                    CursorLine = {
                        bg = u.vary_color({ latte = u.lighten(colors.crust, 0.70, colors.base) }, u.darken(colors.surface0, 0.64, colors.base)),
                    }
                }
            end
        }

        vim.cmd.colorscheme("catppuccin")
    end
}


return{
    catppuccin_theme
}
