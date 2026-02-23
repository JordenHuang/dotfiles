-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This will hold the configuration.
-- local config = wezterm.config_builder()
local config = {}

config.font_size = 13
config.font = wezterm.font_with_fallback({
    "JetBrainsMonoNL Nerd Font Mono",
    "Noto Sans CJK TC",
})

-- config.color_scheme = "catppuccin-frappe"
-- config.force_reverse_video_cursor = true

local catppuccin_frappe_color = wezterm.color.get_builtin_schemes()["catppuccin-frappe"]
catppuccin_frappe_color.cursor_bg = catppuccin_frappe_color.cursor_fg
catppuccin_frappe_color.cursor_fg = catppuccin_frappe_color.background
config.colors = catppuccin_frappe_color

-- Input Method Editor
config.use_ime = true
config.xim_im_name = "ibus"

-- Tab bar
config.enable_tab_bar = false

-- Window border
config.window_decorations = "RESIZE"

-- Window padding
config.window_padding = {
  left = '1cell',
  right = '1cell',
  top = '0cell',
  bottom = '0cell',
}

-- Bell
config.audible_bell = "Disabled"

config.scrollback_lines = 10000
config.enable_scroll_bar = true

-- Do not adjust window size when changing font size
config.adjust_window_size_when_changing_font_size = false

-- Cursor
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_rate = 500
config.cursor_blink_ease_out = "Constant"
config.cursor_blink_ease_in = "Constant"


config.disable_default_key_bindings = true

-- Keybindings
config.keys = {
    -- Shell integration (OSC 133)
    { key = 'UpArrow', mods = 'SHIFT', action = act.ScrollToPrompt(-1) },
    { key = 'DownArrow', mods = 'SHIFT', action = act.ScrollToPrompt(1) },

    -- copy/paste
    { key = 'c',
        mods = 'CTRL|SHIFT',
        action = act.CopyTo('Clipboard')
    },
    {
        key = 'v',
        mods = 'CTRL|SHIFT',
        action = act.PasteFrom('Clipboard')
    },

    -- Scroll line up
    {
        key = 'UpArrow',
        mods = 'CTRL|SHIFT',
        action = act.ScrollByLine(-1)
    },
    {
        key = 'k',
        mods = 'CTRL|SHIFT',
        action = act.ScrollByLine(-1)
    },

    -- Scroll line down
    {
        key = 'DownArrow',
        mods = 'CTRL|SHIFT',
        action = act.ScrollByLine(1)
    },
    {
        key = 'j',
        mods = 'CTRL|SHIFT',
        action = act.ScrollByLine(1)
    },

    -- Scroll page up
    {
        key = 'PageUp',
        mods = 'CTRL|SHIFT',
        action = act.ScrollByPage(-1)
    },
    -- Scroll page down
    {
        key = 'PageDown',
        mods = 'CTRL|SHIFT',
        action = act.ScrollByPage(1)
    },

    -- Scroll to top
    {
        key = 'Home',
        mods = 'CTRL|SHIFT',
        action = act.ScrollToTop
    },
    -- Scroll to bottom
    {
        key = 'End',
        mods = 'CTRL|SHIFT',
        action = act.ScrollToBottom
    },

    {
        key = 'P',
        mods = 'CTRL',
        action = wezterm.action.ActivateCommandPalette,
    },

    -- Increase font size by 10%
    {
        key = '=',
        mods = 'CTRL',
        action = wezterm.action.IncreaseFontSize
    },
    {
        key = 'Add',
        mods = 'CTRL',
        action = wezterm.action.IncreaseFontSize
    },

    -- Decrease font size by 10%
    {
        key = '-',
        mods = 'CTRL',
        action = wezterm.action.DecreaseFontSize
    },
    {
        key = 'Subtract',
        mods = 'CTRL',
        action = wezterm.action.DecreaseFontSize
    },

    -- Reset font size
    {
        key = '0',
        mods = 'CTRL',
        action = wezterm.action.ResetFontAndWindowSize
    },
}

-- Finally, return the configuration to wezterm:
return config
