# Dotfiles

My dotfiles

## Terminal

Wezterm

## Terminal Multiplexer

tmux

plugins:
- catppuccin-tmux
- tmux-resurrect
- tmux-continuum

## Terminal Prompt

Starship

## Editor

Neovim
VSCode

## File Manager

yazi
pcmanfm

## Browser

Firefox

Extensions:
- [eye-friendly theme](https://addons.mozilla.org/zh-TW/firefox/addon/eye-friendly/)
- [Tab Session Manager](https://addons.mozilla.org/zh-TW/firefox/addon/tab-session-manager/)
- [Simple Translate](https://addons.mozilla.org/zh-TW/firefox/addon/simple-translate/)
- [uBlock Origin](https://addons.mozilla.org/zh-TW/firefox/addon/ublock-origin/)

## No CapsLock

`setxkbmap -option ctrl:nocaps`

## Gnome Extension

PaperWM, a scrolling tiling window manager

## Launcher

rofi

## Image Viewer

feh, image viewer (and wallpaper setter, when using a wm)

## Input Method

- Framework: `ibus`
- Engine: `Rime`
- Schema: `luna_pinyin_tw`

Need to setup opencc setting (~/.config/ibus/rime/opencc/t2tw.json), add below to `conversion_chain`:
``` json
    {
      "dict": {
        "type": "ocd2",
        "file": "TWVariants.ocd2"
      }
    },
```

Also setup schema list to include `luna_pinyin_tw`. In `~/.config/ibus/rime/default.custom.yaml`, add:
``` yaml
patch:
  schema_list:
    - schema: luna_pinyin_tw
    - schema: luna_pinyin
    - schema: luna_pinyin_simp
    - schema: luna_pinyin_fluency
    - schema: bopomofo
    - schema: bopomofo_tw
    - schema: cangjie5
    - schema: stroke
    - schema: terra_pinyin
```

Reference:
- https://github.com/rime/home/wiki/UserData
- https://github.com/rime/home/wiki/CustomizationGuide#%E4%B8%80%E4%BE%8B%E5%AE%9A%E8%A3%BD%E6%96%B9%E6%A1%88%E9%81%B8%E5%96%AE
- https://blog.pulipuli.info/2022/04/fixing-the-problem-of-opencc-issues-when-typing-with-bopomofotw-of-fcitx-rime.html

## Video Player

mpv

## Music Daemon

mpd

## Music Client

mpc - command line
rmpc - TUI

## Tools

ytdlp:
YouTube video/audio downloader

yt-x:
TUI YouTube client

---

## I3wm

Window manager

## I3bar

Status bar

## I3lock-fancy

Screen locker

## Xresource

Sets dpi to scale up 200% and sets colors
