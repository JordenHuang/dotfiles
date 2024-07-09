-- Theme
-- colors, borders, gaps, etc.

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local awful = require("awful")

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

-- ===== User variables and applications =====
local user_apps = require("user").apps
local user_keys = require("user").keys
local user_colors = require("user").colors



-- ===== Wallpaper =====
-- gfs.get_configuration_dir() will return the path
-- of the directory that contains the user's rc.lua
-- with a slash at the end
theme.wallpaper = gfs.get_configuration_dir() .. "themes/wallpapers/wallpaper.jpg"
--theme.wallpaper = "~/.config/AMyawesome/themes/wallpapers/wallpaper.jpg"
if theme.wallpaper == nil  then
    theme.wallpaper = themes_path.."default/background.png"
end


-- ===== Fonts =====
theme.font_name = "monospace "
theme.font = theme.font_name .. "10"
theme.wibar_font = theme.font_name .. "Bold 10"
theme.icon_font_name = "monospace "
theme.wibar_icon_font = theme.font_name .. "12"


-- ===== Basic Colors =====
-- ===== Colors =====
theme.background    = user_colors.background
theme.foreground    = user_colors.foreground   
theme.cursorcolor   = user_colors.cursorcolor  
theme.pure_black    = user_colors.foreground
theme.pure_white    = user_colors.background
theme.black         = user_colors.black        
theme.light_black   = user_colors.light_black  
theme.red           = user_colors.red          
theme.light_red     = user_colors.light_red    
theme.green         = user_colors.green        
theme.light_green   = user_colors.light_green  
theme.yellow        = user_colors.yellow       
theme.light_yellow  = user_colors.light_yellow 
theme.blue          = user_colors.blue         
theme.light_blue    = user_colors.light_blue   
theme.magenta       = user_colors.magenta      
theme.light_magenta = user_colors.light_magenta
theme.cyan          = user_colors.cyan         
theme.light_cyan    = user_colors.light_cyan   
theme.white         = user_colors.white        
theme.light_white   = user_colors.light_white  
theme.transparent   = "#00000000"


-- ===== Background Colors =====
theme.bg_normal   = theme.background
theme.bg_focus    = theme.light_blue
theme.bg_urgent   = theme.red
theme.bg_minimize = theme.light_white
theme.bg_systray  = theme.bg_normal

-- ===== Foreground Colors =====
theme.fg_normal   = theme.black
theme.fg_focus    = theme.foreground
theme.fg_urgent   = theme.red
theme.fg_minimize = theme.white -- or maybe light_black


-- ===== Borders =====
-- ===================================================================
theme.border_width        = dpi(3)
theme.border_normal       = theme.light_black
theme.border_focus        = theme.light_blue
theme.border_marked       = theme.light_magenta
theme.border_radius       = dpi(12)

theme.widget_border_width = dpi(2)
theme.widget_border_color = theme.light_black

-- ===== Gaps =====
theme.useless_gap   = dpi(3)

-- ===== Wibar =====
theme.wibar_position      = "top"
theme.wibar_height        = dpi(27)
-- theme.wibar_width = dpi(1366)
theme.wibar_bg            = theme.background
theme.wibar_fg            = theme.foreground
-- theme.wibar_border_color = theme.black
theme.wibar_border_width  = dpi(0)
theme.wibar_border_radius = dpi(0)



-- ===== Taglist =====
theme.taglist_layout        = {
    -- awful.layout.layouts[1], 
    awful.layout.suit.tile,
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.floating,
    awful.layout.suit.floating,
}
theme.taglist_text_font     = theme.wibar_icon_font
theme.taglist_text_empty    = { " 󱓻 ", " 󱓻 ", " 󱓻 ", " 󱓻 ", " 󱓻 " }
theme.taglist_text_occupied = { "", "", "", "", "" }
theme.taglist_text_focused  = { "", "", "", "", "" }
theme.taglist_text_urgent   = { "", "", "", "", "" }

theme.taglist_text_color_empty = {
    theme.light_black,
    theme.light_black,
    theme.light_black,
    theme.light_black,
    theme.light_black,
}
theme.taglist_text_color_occupied = {
	theme.light_yellow,
	theme.light_yellow,
	theme.light_yellow,
	theme.light_yellow,
	theme.light_yellow,
}
theme.taglist_text_color_focused = {
	theme.light_yellow,
	theme.light_yellow,
	theme.light_yellow,
	theme.light_yellow,
}
theme.taglist_text_color_urgent = {
	theme.light_red,
	theme.light_red,
	theme.light_red,
	theme.light_red,
}

-- {{{
-- -- ===== Text Taglist (default) =====
-- theme.taglist_font          = theme.wibar_font
-- theme.taglist_bg_focus      = theme.wibar_bg
-- theme.taglist_fg_focus      = theme.fg_focus
-- theme.taglist_bg_occupied   = theme.wibar_bg
-- theme.taglist_fg_occupied   = theme.fg_normal
-- theme.taglist_bg_empty      = theme.wibar_bg
-- theme.taglist_fg_empty      = theme.light_black
-- theme.taglist_bg_urgent     = theme.wibar_bg
-- theme.taglist_fg_urgent     = theme.fg_urgent
-- theme.taglist_disable_icon  = true
-- theme.taglist_spacing       = dpi(0)
-- local taglist_square_size   = dpi(0)
-- theme.taglist_squares_sel   = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_focus)
-- theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)
-- 
-- -- ===== Generate taglist squares: =====
-- local taglist_square_size = dpi(4)
-- theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
--     taglist_square_size, theme.fg_normal
-- )
-- theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
--     taglist_square_size, theme.fg_normal
-- )
-- }}}


-- ===== Tasklist =====
theme.tasklist_font            = theme.font
theme.tasklist_disable_icon    = false
theme.tasklist_plain_task_name = true
theme.tasklist_bg_focus        = theme.wibar_bg
theme.tasklist_fg_focus        = theme.black
theme.tasklist_bg_normal       = theme.wibar_bg
theme.tasklist_fg_normal       = theme.light_black
theme.tasklist_bg_minimize     = theme.bg_minimize
theme.tasklist_fg_minimize     = theme.fg_minimize
theme.tasklist_bg_urgent       = theme.bg_urgent
theme.tasklist_fg_urgent       = theme.fg_urgent
theme.tasklist_align           = "left"



-- ===== Menu =====
-- Variables set for theming the menu:
theme.menu_height       = dpi(30)
theme.menu_width        = dpi(150)
theme.menu_bg_normal    = theme.bg_normal
theme.menu_fg_normal    = theme.fg_normal
theme.menu_bg_focus     = theme.bg_focus
theme.menu_fg_focus     = theme.pure_white
theme.menu_border_width = theme.widget_border_width
theme.menu_border_color = theme.widget_border_color


-- ===== Titlebar =====
theme.titlebar_enabled = false


-- ===== Layout Icons =====
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"



-- ===== Miscellaneous =====
-- Hotkeys popup
theme.hotkeys_modifiers_fg = theme.blue


-- ===== Generate Awesome icon =====
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
