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


--[[
user.colors = {
    background    = "#fdfdfd",
    foreground    = "#000000",
    cursorcolor   = "#000000",
    black         = "#242424",
    light_black   = "#666666",
    red           = "#c20a0a",
    light_red     = "#d74242",
    green         = "#38c20a",
    light_green   = "#67d742",
    yellow        = "#da730b",
    light_yellow  = "#e28c36",
    blue          = "#0a66c2",
    light_blue    = "#368ce2",
    magenta       = "#733fa6",
    light_magenta = "#9b36e2",
    cyan          = "#0a94c2",
    light_cyan    = "#36b7e2",
    white         = "#cdcdcd",
    light_white   = "#eaeaea",
}
]]
user.colors = {
    background    = "#fdfdfd",
    foreground    = "#000000",
    cursorcolor   = "#000000",
    black         = "#242424",
    light_black   = "#666666",
    red           = "#c20a0a",
    light_red     = "#e06c6c",
    green         = "#38c20a",
    light_green   = "#89e06c",
    yellow        = "#da730b",
    light_yellow  = "#e9a663",
    blue          = "#0a66c2",
    light_blue    = "#63a6e9",
    magenta       = "#733fa6",
    light_magenta = "#b78fef",
    cyan          = "#0a94c2",
    light_cyan    = "#63c7e9",
    white         = "#cdcdcd",
    light_white   = "#eaeaea",
}

return user
--[[
--original
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
--------------------------------------
===== Version 2 =====
--------------------------------------------

# my color (hsl)
! special
background
foreground
cursorcolor
"#fdfdfd"
"#000000"
"#000000"
#191919

! black
"#242424"
"#666666"

! red
0, 90, 40       #c20a0a
0, 65, 65       #e06c6c #d74242  (l 各降10)

! green
105, 90, 40     #38c20a
105, 65, 65     #89e06c #67d742

! yellow
30, 90, 45      #da730b
30, 75, 65      #e9a663 #e28c36

! blue
210, 90, 40     #0a66c2
210, 75, 65     #63a6e9 #368ce2

! magenta
270, 45, 45     #733fa6
265, 75, 75     #B78FEF #9b36e2

! cyan
195, 90, 40     #0a94c2
195, 75, 65     #63c7e9 #36b7e2

! white
"#cdcdcd"
"#eaeaea"
--]]




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


--[[ looks good
$background: #1A1B26;
$background-alt: #16161E;
$background-alt2: #1E202E;
$foreground: #a9b1d6;
$red: #F7768E;
$yellow: #E0AF68;
$orange: #FF9E64;
$green: #9ECE6A;
$blue: #7AA2F7;
$blue2: #88AFFF;
$magenta: #BB9AF7;
$cyan: #73DACA;
]]
