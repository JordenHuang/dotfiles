-- Memory usage widget (ram widget)
-- Create by myself

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local update_interval = 15
-- awk is a command tool (it's also a language)
-- NR means line number, start from 1
-- so the script below prints the line number 2's third data
-- try this: free -m | awk '{print NR,$1,$2,$3}'
local script = [[ free -m | awk 'NR==2 {print $3}']]





memory_widget = wibox.widget({
	{
		{
			{
				id = "text",
                text = " ",
				font = beautiful.wibar_font,
				widget = wibox.widget.textbox,
			},
			left = dpi(5),
			right = dpi(5),
			widget = wibox.container.margin,
		},
		layout = wibox.layout.fixed.horizontal,
	},
	fg = beautiful.green,
	bg = beautiful.wibar_bg,
	widget = wibox.container.background,
})

awesome.connect_signal("desktop.widgets::ram", function(used, total)
	memory_widget:get_children_by_id("text")[1].markup = " " .. tostring(used) .. " GiB"
end)





-- Update ram usage
local update_ram = function()
    awful.spawn.easy_async_with_shell(
        script,
        function(out)
            local usage = string.gsub(out, "%s+", "")
            local str = string.format("%.2f", tonumber(usage) / 1000)
            awesome.emit_signal("desktop.widgets::ram", str)
        end
    )
end

local update_ram_timer = gears.timer(
    {
        timeout = update_interval,
        call_now = true,
        auto_start = true,
        callback = update_ram
    }
)
