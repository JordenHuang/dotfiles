-- Memory usage widget (ram widget)
-- Create by myself
-- Two usful webpage that helped me a lot
-- https://www.reddit.com/r/awesomewm/comments/nq4ut2/how_to_use_gearstimer/
-- https://www.reddit.com/r/awesomewm/comments/f2lpai/update_variable_using_the_stdout_of_easy_async/

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
local script = [[ bash -c "free -m | awk 'NR==2 {print $3}'" ]]



memory_widget = wibox.widget({
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
	fg = beautiful.green,
	bg = beautiful.wibar_bg,
	widget = wibox.container.background,
})

awesome.connect_signal("desktop.widgets::ram", function(used, total)
	memory_widget:get_children_by_id("text")[1].markup = " " .. tostring(used) .. " GiB"
end)



-- Periodically update ram info
awful.widget.watch(
    [[bash -c "free -m | awk 'NR==2 {print $3}'"]],
    update_interval,
    function(widget, stdout)
        local used = stdout:gsub("%s+", "")
        used = string.format("%.2f", tonumber(used) / 1000)
        awesome.emit_signal("desktop.widgets::ram", used, nil)
    end
)






-- The code below only update ram usage once

-- -- Update ram usage
-- local update_ram = function()
--     awful.spawn.easy_async_with_shell(
--         script,
--         function(out)
--             local usage = string.gsub(out, "%s+", "")
--             --local str = string.format("%.2f", tonumber(usage) / 1000)
--             local str = string.format("%.3f", tonumber(usage) / 1000)
--             awesome.emit_signal("desktop.widgets::ram", str)
--         end
--     )
-- end
-- 
-- update_ram_timer = gears.timer(
--     {
--         timeout = 3,
--         call_now = true,
--         auto_start = true,
--         callback = update_ram
--     }
-- )

