local function getGreeting(name)
    local tableTime = os.date("*t")
    local hour = tableTime.hour
    local datetime = " " .. os.date("%Y-%m-%d  ") .. " " .. os.date("%H:%M")
    local greetingIndex = 0
    local greetingsTable = {
        [1] = " Good morning",
        [2] = " Good afternoon",
        [3] = " Good evening",
        [4] = "󰖔 Good night",
    }

    if hour >= 5 and hour < 12 then
        greetingIndex = 1
    elseif hour >= 12 and hour < 18 then
        greetingIndex = 2
    elseif hour >= 18 and hour < 21 then
        greetingIndex = 3
    else
        greetingIndex = 4
    end
    return " " .. datetime .. "  " .. greetingsTable[greetingIndex] .. ", " .. name
end



local M = {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
}


function M.config()
    local alpha = require "alpha"
    local dashboard = require "alpha.themes.dashboard"
    -- Set header
    dashboard.section.header.val = {
        "                                                    ",
        " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "                                                    ",
    }

    local user_name = "Qinuo"
    local greeting_section = {
        type = "text",
        val = getGreeting(user_name),
        opts = {
            position = "center",
            hl = "Type",
        }
    }

    local function ask_path()
        local cwd = vim.fn.expand("%:p:h").."/"
        vim.ui.input(
            { prompt = "Search path: ", default = cwd, completion = "file"},
            function(cmd)
                if cmd == nil or cmd == '' then
                    return
                else
                    vim.cmd(":FzfLua files cwd=" .. cmd)
                end
            end
        )
    end

    dashboard.section.buttons.val = {
        dashboard.button("n", "  New file",           "<cmd>enew<CR>"),
        dashboard.button("f", "󰱼  Find files",         "<cmd>FzfLua files<CR>"),
        dashboard.button("F", "󰱼  Find files in path", ask_path),
        dashboard.button("l", "󰷾  Find text",          "<cmd>FzfLua live_grep<CR>"),
        dashboard.button("r", "  Find recent files",  "<cmd>FzfLua oldfiles<CR>"),
        dashboard.button("y", "󰱼  Open Yazi",          "<cmd>Yazi cwd<CR>"),
        dashboard.button("l", "󰒲  Lazy panel",         ":Lazy<CR>"),
        dashboard.button("q", "  Quit",               "<cmd>qa<CR>"),
        -- When using Telescope
        -- dashboard.button("f", "󰱼  Find files",        "<cmd>Telescope find_files<CR>"),
        -- dashboard.button("g", "󰷾  Find text",         ":Telescope live_grep<CR>"),
        -- dashboard.button("r", "  Find recent files", "<cmd>Telescope oldfiles<CR>"),
    }

    -- set highlight
    dashboard.section.header.opts.hl = "AlphaHeader"
    for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
    end
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.footer.opts.hl = "AlphaFooter"


    local my_config = {
        layout = {
            { type = "padding", val = 2 },
            dashboard.section.header,
            greeting_section,
            { type = "padding", val = 2 },
            dashboard.section.buttons,
            dashboard.section.footer,
        },
        opts = {
            margin = 5,
        },
    }

    alpha.setup(my_config)
end



return M
