-- All user variables or colors
local user = {}

-- User programs
user.apps = {
    terminal = "gnome-terminal",
    scratchpad_terminal = "gnome-terminal --class scratchpad",
    editor = "gnome-terminal -e nvim",
    gui_editor = "code",
    browser = "google-chrome",
    file_manager = "gnome-terminal -e ranger",
    gui_file_manager = "pcmanfm",
}


user.keys = {
    modkey = "Mod4", -- Win key
    alt = "Mod1",
    shift = "Shift",
    ctrl = "Control",
    tab = "Tab",
}


user.colors = {
    background    = "#fdfdfd",
    foreground    = "#000000",
    cursorcolor   = "#000000",
    black         = "#242424",
    light_black   = "#666666",
    red           = "#cc0000",
    light_red     = "#e96363",
    green         = "#33cc00",
    light_green   = "#84e963",
    yellow        = "#cc6600",
    light_yellow  = "#e9a663",
    blue          = "#0044cc",
    light_blue    = "#638fe9",
    magenta       = "#7700cc",
    light_magenta = "#b163e9",
    cyan          = "#00bbcc",
    light_cyan    = "#63dee9",
    white         = "#cdcdcd",
    light_white   = "#eaeaea",
}


return user


-- colors' HSL and RGB value
--[[
# my color (hsl)
! special
"#fdfdfd"
"#000000"
"#000000"

! black
"#242424"
"#666666"

! red
0, 100, 40      #cc0000
0, 75, 65       #e96363

! green
105, 100, 40    #33cc00
105, 75, 65     #84e963

! yellow
30, 100, 40     #cc6600
30, 75, 65      #e9a663

! blue
220, 100, 40    #0044cc
220, 75, 65     #638fe9

! magenta
275, 100, 40    #7700cc
275, 75, 65     #b163e9

! cyan
185, 100, 40    #00bbcc
185, 75, 65     #63dee9

! white
"#cdcdcd"
"#eaeaea"

]]--
