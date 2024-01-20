-- Create tags

-- NOT working

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- ===== User variables and applications =====
local user_apps = require("user").apps
local user_keys = require("user").keys
local user_colors = require("user").colors


local function rounded_shape(size)
    return function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, size)
    end
end


-- ===== Create tage =====
awful.screen.connect_for_each_screen(
    function(s)
        for i = 1, #beautiful.taglist_layout, 1 do
            awful.tag.add(
                tostring(i),
                {
                    icon = v,
                    layout = v,
                    screen = s,
                    --screen = true--i == 1 and true or false,
                }
            )
        end
    end
)
