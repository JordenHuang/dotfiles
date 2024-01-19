-- Awesome Window Manager
-- configuration file
-- this file binds everything together


-- ===== HINT =====
-- Use the below command to test the rc.lua
-- ` Xephyr :5 & sleep 1 ; DISPLAY=:5 awesome -c "PATH TO THE rc.lua" `


-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
--require("awful.hotkeys_popup.keys")
local gfs = require("gears.filesystem")

-- ===== User variables and applications =====
local user_apps = require("user").apps
local user_keys = require("user").keys
local user_colors = require("user").colors


-- ===== Stable version =====
-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- ===== Git version =====
-- {{{ Error handling
-- naughty.connect_signal("request::display_error", function(message, startup)
-- 	naughty.notification({
-- 		urgency = "critical",
-- 		title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
-- 		message = message,
-- 	})
-- end)
-- }}}


-- ===== Load theme =====
-- Themes define colours, icons, font and wallpapers.
-- Default theme
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
-- Custom theme
beautiful.init(gfs.get_configuration_dir() .. "themes/theme.lua")


-- ===== Layouts =====
-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}

-- ===== Load menu and launcher lua file =====
require("desktop.menu")


-- ===== Load Topbar (wibar) =====
require("desktop.topbar")


-- ===== Load key bindings =====
require("keys")


-- ===== Signals =====
-- {{{
-- Border color
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)



-- ===== Set wallpaper to each screen =====
local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(
    function(s)
        -- Wallpaper
        set_wallpaper(s)
    end
)


-- -- Enable sloppy focus, so that focus follows mouse
-- client.connect_signal("mouse::enter", function(c)
--     c:emit_signal("request::activate", "mouse_enter", {raise = false})
-- end)


-- Set mouse resize mode (live or after)
awful.mouse.resize.set_mode("live")


-- ===== Restore geometry for floating clients =====
-- (for example after swapping from tiling mode to floating mode)
require("helpers.restore_floating_clients")

-- }}}


-- ===== Rules =====
-- {{{
-- Rules to apply to new clients (through the "manage" signal).

local floating_client_placement = function(c)
    -- If the layout is floating or there are no other visible
    -- clients, center client
    if awful.layout.get(mouse.screen) ~= awful.layout.suit.floating or #mouse.screen.clients == 1 then
        return awful.placement.centered(c)--, { honor_padding = true, honor_workarea = true })
    else
        local p = awful.placement.no_overlap + awful.placement.no_offscreen
        return p(c, { honor_padding = true, honor_workarea = true, margins = beautiful.useless_gap * 2 })
    end
end

awful.rules.rules = {
    -- All clients will match this rule.
    { 
        rule = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.focused,
			--size_hints_honor = false,
			--honor_workarea = true,
			--honor_padding = true,
            titlebars_enabled = beautiful.titlebars_enabled,
            placement = floating_client_placement,
        }
    },
    
    -- Floating clients.
    -- I think maybe I don't need this rule
    -- For class and instance, see the link below
    -- https://awesomewm.org/doc/api/classes/client.html#client.class
    -- { 
    --     rule_any = {
    --         instance = {
    --             "DTA",  -- Firefox addon DownThemAll.
    --             "copyq",  -- Includes session name in class.
    --             "pinentry",
    --         },
    --         class = {
    --             "Arandr",
    --             "Blueman-manager",
    --             "Gpick",
    --             "Kruler",
    --             "MessageWin",  -- kalarm.
    --             "Sxiv",
    --             "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
    --             "Wpa_gui",
    --             "veromix",
    --             "xtightvncviewer"
    --         },

    --         -- Note that the name property shown in xprop might be set slightly after creation of the client
    --         -- and the name shown there might not match defined rules here.
    --         name = {
    --             "Event Tester",  -- xev.
    --         },
    --         role = {
    --             "AlarmWindow",  -- Thunderbird's calendar.
    --             "ConfigManager",  -- Thunderbird's about:config.
    --             "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
    --         }
    --     },
    --     properties = { floating = true }
    -- },

    -- Maximized clients
    {
        rule_any = {
            instance = {
                "google-chrome",
                "firefox",
            },
        },
        properties = { 
            maximized = true, 
            placement = awful.placement.centered
        }
    },
}
-- }}}
