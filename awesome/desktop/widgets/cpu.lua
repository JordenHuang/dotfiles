-- CPU widget
-- Create by myself

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local update_interval = 15
local script = [[ bash -c "echo ""$[100-$(vmstat 1 2|tail -1|awk '{print $15}')]"%"" ]]


-- CPU widget
-- ===================================================================
cpu_widget = wibox.widget({
    {
        {
            {
                id = "text",
                text = " ",
                font = beautiful.wibar_font,
                widget = wibox.widget.textbox,
            },
            left = dpi(5),
            right = dpi(5),
            widget = wibox.container.margin,
        },
        layout = wibox.layout.fixed.horizontal,
    },
    fg = beautiful.cyan,
    bg = beautiful.wibar_bg,
    widget = wibox.container.background,
})

awesome.connect_signal("desktop.widgets::cpu", function(cpu_idle)
    cpu_widget:get_children_by_id("text")[1].markup = " " .. tostring(cpu_idle)
end)


-- Update cpu usage every update_interval
awful.widget.watch(
    script,
    update_interval,
    function(widget, stdout)
        local used = stdout:gsub("%s+", "")
        awesome.emit_signal("desktop.widgets::cpu", used)
    end
)





-- The code below only update cpu usage once

-- --Update cpu_usage every time
-- local update_cpu = function()
--     awful.spawn.easy_async_with_shell(
--         script,
--         function(out)
--             local str = string.gsub(out, "%s+", "")
--             awesome.emit_signal("desktop.widgets::cpu", str)
--         end
--     )
-- end
-- 
-- local update_cpu_timer = gears.timer(
--     {
--         timeout = update_interval,
--         call_now = true,
--         auto_start = true,
--         callback = update_cpu
--     }
-- )

