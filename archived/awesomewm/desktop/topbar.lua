-- Create Topbar (wibar) and add widgets to it

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

-- ===== Topbar Widgets =====
-- {{{
-- ===== Keyboard map indicator and switcher =====
mykeyboardlayout = awful.widget.keyboardlayout()


-- ===== Textclock and Calendar Widget =====
require("desktop.widgets.clock_and_calendar")


-- ===== CPU Widget =====
require("desktop.widgets.cpu")


-- ===== RAM Widget =====
require("desktop.widgets.ram")


-- ===== Create a wibox for each screen and add it =====
local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ user_keys.modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ user_keys.modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal(
                "request::activate",
                "tasklist",
                {raise = true}
            )
        end
    end),
    awful.button({ }, 3, function()
        awful.menu.client_list({ theme = { width = 250 } })
    end),
    awful.button({ }, 4, function ()
        awful.client.focus.byidx(1)
    end),
    awful.button({ }, 5, function ()
        awful.client.focus.byidx(-1)
    end)
)

-- Add to every screen
-- require("desktop.widgets.tags")
awful.screen.connect_for_each_screen(
    function(s)

        -- Each screen has its own tag table.
        awful.tag(
            { "1", "2", "3", "4", "5" },
            s,
            {
                awful.layout.layouts[1], 
                awful.layout.suit.tile,
                awful.layout.suit.floating,
                awful.layout.suit.floating,
                awful.layout.suit.floating,
            }
        )

        -- Create a promptbox for each screen
        s.mypromptbox = awful.widget.prompt()
        -- Create an imagebox widget which will contain an icon indicating which layout we're using.
        -- We need one layoutbox per screen.
        s.mylayoutbox = awful.widget.layoutbox(s)
        s.mylayoutbox:buttons(gears.table.join(
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
            awful.button({ }, 4, function () awful.layout.inc( 1) end),
            awful.button({ }, 5, function () awful.layout.inc(-1) end))
        )
        -- Create a taglist widget
        s.mytaglist = awful.widget.taglist {
            screen  = s,
            filter  = awful.widget.taglist.filter.all,
            buttons = taglist_buttons
        }

        -- Create a tasklist widget
        s.mytasklist = awful.widget.tasklist {
            screen  = s,
            filter  = awful.widget.tasklist.filter.currenttags,
            buttons = tasklist_buttons,
            style   = {
                disable_task_name = true,
                font = beautiful.tasklist_font,
                bg = beautiful.tasklist_bg_normal,
            },
            layout = {
                spacing = dpi(4),
                layout = wibox.layout.flex.horizontal,
            },
        }

        s.myseparator = wibox.widget.textbox("      ")

        -- Create the wibox
        s.mywibox = awful.wibar({ position = beautiful.wibar_position, screen = s, type = "dock" })

        -- Add widgets to the wibox
        s.mywibox:setup {
            {
                expand = "none",
                layout = wibox.layout.align.horizontal,
                { -- Left widgets
                    layout = wibox.layout.fixed.horizontal,
                    align = "left",
                    mylauncher,
                    s.mytaglist,
                    s.mypromptbox,
                    s.myseparator,
                    s.mytasklist,
                },
                { -- Middle widget
                    layout = wibox.layout.fixed.horizontal,
                    align = "center",
                    mytextclock,
                },
                { -- Right widgets
                    layout = wibox.layout.fixed.horizontal,
                    align = "right",
                    cpu_widget,
                    memory_widget,
                    mykeyboardlayout,
                    wibox.widget.systray(),
                    s.mylayoutbox,
                },
            },
            top = dpi(3),
            bottom = dpi(3),
            left = dpi(3),
            right = dpi(3),
            widget = wibox.container.margin,
        }
        -- Place bar at the top and add margins
        awful.placement.top(s.mywibox)--, { margins = beautiful.screen_margin * 0 }) -- No margin
    end
)
-- }}}
