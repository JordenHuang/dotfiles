-- Create Menu and left up corner icon button

local gears = require("gears")
local awful = require("awful")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- ===== User variables and applications =====
local user_apps = require("user").apps
local user_keys = require("user").keys

-- ===== Menu (mouse rightclick thing) =====
-- {{{
-- Create a launcher widget and a main menu
local myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", user_apps.terminal .. " -e man awesome" },
   { "edit config", user_apps.editor .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

local menu_awesome = { "awesome", myawesomemenu, beautiful.awesome_icon }
local menu_terminal = { "open terminal", user_apps.terminal }

mymainmenu = awful.menu({
    items = {
        menu_awesome,
        menu_terminal,
    }
})


-- ===== Menubar configuration =====
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}
