local which_key = {
    "folke/which-key.nvim",
    tag = "v3.17.0",
    event = "VeryLazy",
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        preset = "helix",
        delay = function(ctx)
            return ctx.plugin and 0 or 1750
        end,
        icons = {
            keys = {
                Up = " ",
                Down = " ",
                Left = " ",
                Right = " ",
                C = "C- ",
                M = "M- ",
                D = "󰘳 ",
                S = "S- ",
                CR = "<CR> ",
                Esc = "󱊷 ",
                ScrollWheelDown = "󱕐 ",
                ScrollWheelUp = "󱕑 ",
                NL = "<CR> ",
                BS = "󰁮",
                Space = "SPACE ",
                Tab = "󰌒 ",
                F1 = "󱊫",
                F2 = "󱊬",
                F3 = "󱊭",
                F4 = "󱊮",
                F5 = "󱊯",
                F6 = "󱊰",
                F7 = "󱊱",
                F8 = "󱊲",
                F9 = "󱊳",
                F10 = "󱊴",
                F11 = "󱊵",
                F12 = "󱊶",
            },
        }
    },
}

return {
    which_key
}
