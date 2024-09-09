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
                return {
                    CursorLine = {
                        bg = u.vary_color({ latte = u.lighten(colors.crust, 0.70, colors.base) }, u.darken(colors.surface0, 0.64, colors.base)),
                    },
                    --- Trying to create my own color scheme
                    Comment =           { fg = u.darken(colors.green, 0.70, "#203050") }, -- just comments
                --     SpecialComment =    { link = "Special"  }, -- special things inside a comment
                --     Constant =          { link = "Type"     }, -- (preferred) any constant
                --     String =            { fg = colors.green }, -- a string constant: "this is a string"
                --     Character =         { link = "String"   }, -- a character constant: 'c', '\n'
                --     Number =            { link = "Type"     }, -- a number constant: 234, 0xff
                --     Float =             { link = "Number"   }, -- a floating point constant: 2.3e10
                --     Boolean =           { link = "Type"     }, -- a boolean constant: TRUE, false
                --     Identifier =        { fg = colors.pink  }, -- (preferred) any variable name
                --     Function =          { fg = colors.blue  }, -- function name (also: methods for classes)
                --     Statement =         { link = "Type"     }, -- (preferred) any statement
                --     Conditional =       { link = "Type"     }, -- if, then, else, endif, switch, etc.
                --     Repeat =            { link = "Type"     }, -- for, do, while, etc.
                --     Label =             { fg = colors.sky   }, -- case, default, etc.
                --     Operator =          { fg = colors.sky   }, -- "sizeof", "+", "*", etc.
                --     Keyword =           { link = "PreProc"  }, -- any other keyword
                --     Exception =         { link = "PreProc"  }, -- try, catch, throw
                --
                --     PreProc =           { fg = colors.mauve }, -- (preferred) generic Preprocessor
                --     Include =           { link = "PreProc"  }, -- preprocessor #include
                --     Define =            { link = "PreProc"  }, -- preprocessor #define
                --     Macro =             { link = "PreProc"  }, -- same as Define
                --     PreCondit =         { link = "PreProc"  }, -- preprocessor #if, #else, #endif, etc.
                --
                --     StorageClass =      { link = "Type"        }, -- static, register, volatile, etc.
                --     Structure =         { link = "Type"        }, -- struct, union, enum, etc.
                --     Special =           { fg = colors.pink     }, -- (preferred) any special symbol
                --     Type =              { fg = colors.yellow   }, -- (preferred) int, long, char, etc.
                --     Typedef =           { link = "Type"        }, -- A typedef
                --     SpecialChar =       { link = "Special"     }, -- special character in a constant
                --     Tag =               { fg = colors.lavender }, -- you can use CTRL-] on this
                --     Delimiter =         { fg = colors.overlay2 }, -- character that needs attention
                --     Debug =             { link = "Special"     }, -- debugging statements
                }
            end
        }

        vim.cmd.colorscheme("catppuccin")
    end
}


return{
    catppuccin_theme
}
