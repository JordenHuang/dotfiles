-- Textclock and Calendar widget

-- Standard awesome library
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
local user_colors = require("user").colors


local function rounded_shape(size)
    return function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, size)
    end
end


-- ===== Calendar widget =====
local month_calendar = wibox.widget({
    date = os.date("*t"),
    spacing = 10,
    start_sunday = true,
    long_weekdays = true,
    widget = wibox.widget.calendar.month,
})

local calendar_popup = awful.popup({
    ontop = true,
    visible = false,
    shape = rounded_shape(8),
    border_width = beautiful.widget_border_width,
    border_color = beautiful.widget_border_color,
    placement = awful.placement.top,
    widget = month_calendar,
})

local function calendar_popup_toggle()
    if calendar_popup.visible then
        calendar_popup.visible = not calendar_popup.visible
    else
        calendar_popup.visible = true
        awful.placement.top(
            calendar_popup, 
            { 
                margins = { top = 27 }, 
            }
        )
    end
end


-- ===== Create a textclock widget =====
--mytextclock = wibox.widget.textclock()
mytextclock = wibox.widget({
	{
		{
			id = "clock_role",
			format = "<b>" .. "%H:%M" .. "</b>",
			refresh = 60,
			font = beautiful.wibar_font,
			widget = wibox.widget.textclock(),
		},
		margins = 4,
		widget = wibox.container.margin,
	},
	shape = rounded_shape(10),
    bg = beautiful.wibar_bg,
	widget = wibox.container.background,
	--buttons = {
	--	awful.button({}, 1, function()
	--		calendar_popup_toggle()
    --        --mytextclock.bg = beautiful.blue
	--	end),
    --}
})

mytextclock.buttons = {
    awful.button({}, 1, function()
        -- TODO: color changing not working
        calendar_popup_toggle()
        --if mytextclock.bg == beautiful.red then
        --    mytextclock.bg = beautiful.blue
        --else
        --    mytextclock.bg = beautiful.red
        --end
    end),
}
