-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
-- For example, changing the color scheme:
config.color_scheme = 'AdventureTime'
config.font = wezterm.font('OperatorMono Nerd Font', { weight = 'ExtraBold' })
config.font_size = 17.0

config.hide_tab_bar_if_only_one_tab = true

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

local act = wezterm.action

config.keys = {
    -- make opt + ¥ on MacOS Japanese keyboard send \
    {
        key = '¥',
        mods = 'ALT',
        action = act.SendString '\\',
    },
    -- make opt + leftarrow behave as moving cursor forwards by one word
    {
        key = 'LeftArrow',
        mods = 'ALT',
        action = act.SendKey {
            key = 'b',
            mods = 'ALT'
        }
    },
    -- make opt + rightarrow behave as moving cursor backwards by one word
    {
        key = 'RightArrow',
        mods = 'ALT',
        action = act.SendKey {
            key = 'f',
            mods = 'ALT'
        }
    },
}

-- and finally, return the configuration to wezterm
return config
