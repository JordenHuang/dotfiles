local catppuccin_theme = {
    "catppuccin/nvim", name = "catppuccin", priority = 1000,
    config = function()
        require("catppuccin").setup {
            flavour = "latte", -- latte, frappe, macchiato, mocha
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
                return{
                    CursorLine = {
                        bg = U.vary_color({ latte = U.lighten(C.crust, 0.70, C.base) }, U.darken(C.surface0, 0.64, C.base)),
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
