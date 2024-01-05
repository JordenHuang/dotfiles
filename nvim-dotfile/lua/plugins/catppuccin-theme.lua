return{
    {
        "catppuccin/nvim", name = "catppuccin", priority = 1000,
        config = function()
            require("catppuccin").setup {
                color_overrides = {
                    all = {
                        text = "#000000"
                    },
                    latte = {
                        base = "#fbfbfb",
                        mantle = "#ededed",
                        crust = "#d0d0d0",
                    },
                    -- frappe = {},
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
            vim.cmd.colorscheme("catppuccin-latte")
        end
    }
}
