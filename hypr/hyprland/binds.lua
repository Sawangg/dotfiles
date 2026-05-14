local programs = require("hyprland.programs")
local mod = "SUPER"

-- Programs --
hl.bind(mod .. " + T", hl.dsp.exec_cmd(programs.terminal))
hl.bind(mod .. " + C", hl.dsp.window.kill())
hl.bind(mod .. " + R", hl.dsp.exec_cmd(programs.menu))
hl.bind(mod .. " + B", hl.dsp.exec_cmd(programs.browser))
hl.bind(mod .. " + SHIFT + B", hl.dsp.exec_cmd(programs.browser .. " -private-window"))
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mod .. " + P", hl.dsp.exec_cmd(programs.color_picker))
hl.bind(mod .. " + SHIFT + P", hl.dsp.window.pin({ action = "toggle" }))
hl.bind(mod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + Q", hl.dsp.exit())

-- Move across & to a workspace --
for workspace = 1, 10 do
  local key = tostring(workspace % 10)
  hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
  hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }))
end

-- Move focus with vim keys or arrow keys --
for _, bind in ipairs({
  { "left", "l" },
  { "H", "l" },
  { "down", "d" },
  { "J", "d" },
  { "up", "u" },
  { "K", "u" },
  { "right", "r" },
  { "L", "r" },
}) do
  hl.bind(mod .. " + " .. bind[1], hl.dsp.focus({ direction = bind[2] }))
end

-- Resize active window with shift + vim keys or arrow keys --
for _, bind in ipairs({
  { "left", -20, 0 },
  { "H", -20, 0 },
  { "down", 0, 20 },
  { "J", 0, 20 },
  { "up", 0, -20 },
  { "K", 0, -20 },
  { "right", 20, 0 },
  { "L", 20, 0 },
}) do
  hl.bind(
    mod .. " + SHIFT + " .. bind[1],
    hl.dsp.window.resize({ x = bind[2], y = bind[3], relative = true }),
    { repeating = true }
  )
end

-- Move & resize windows with mouse --
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Audio --
hl.bind(
  "XF86AudioRaiseVolume",
  hl.dsp.exec_cmd([[wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+]]),
  { repeating = true }
)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd([[wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-]]), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd([[wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle]]), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd([[wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle]]), { locked = true })

-- Media control --
hl.bind(
  "XF86AudioPlay",
  hl.dsp.exec_cmd([[playerctl play-pause && notify-send -t 2000 "Player" "$(playerctl status)"]]),
  { locked = true }
)
hl.bind(
  "XF86AudioPause",
  hl.dsp.exec_cmd([[playerctl play-pause && notify-send -t 2000 "Player" "$(playerctl status)"]]),
  { locked = true }
)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd([[playerctl next]]), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd([[playerctl previous]]), { locked = true })
hl.bind(
  "Pause",
  hl.dsp.exec_cmd([[playerctl play-pause && notify-send -t 2000 "Player" "$(playerctl status)"]]),
  { locked = true }
)

-- Screen brightness --
hl.bind("XF86ScreenSaver", hl.dsp.exec_cmd([[hyprctl dispatch dpms off]]), { locked = true })
hl.bind(
  "XF86MonBrightnessDown",
  hl.dsp.exec_cmd([[brightnessctl set 5%- && notify-send -t 2000 "Brightness" "$(brightnessctl -m | cut -d, -f4)"]]),
  { repeating = true }
)
hl.bind(
  "XF86MonBrightnessUp",
  hl.dsp.exec_cmd([[brightnessctl set +5% && notify-send -t 2000 "Brightness" "$(brightnessctl -m | cut -d, -f4)"]]),
  { repeating = true }
)

-- Night light filter --
hl.bind(
  mod .. " + N",
  hl.dsp.exec_cmd(
    [[pgrep -x "hyprsunset" > /dev/null 2>&1 && { killall hyprsunset; notify-send -t 2000 "Night light" "Disabled"; } || { hyprsunset -t 2500 & disown; notify-send -t 2000 "Night light" "Enabled"; }]]
  )
)

-- Screenshot --
hl.bind(
  "Print",
  hl.dsp.exec_cmd([[slurp | grim -g - - | wl-copy && notify-send -t 2000 "Screenshot" "Saved in clipboard"]])
)
hl.bind("SHIFT + Print", hl.dsp.exec_cmd([[slurp | grim -g - ~/screenshot.png]]))
hl.bind(
  mod .. " + Print",
  hl.dsp.exec_cmd(
    [[slurp | grim -g - - | ~/Documents/scripts/ocr/.venv/bin/python ~/Documents/scripts/ocr/main.py | wl-copy]]
  )
)

-- Pass binding to OBS Studio --
hl.bind(mod .. " + F10", hl.dsp.pass({ window = [[class:^(com\.obsproject\.Studio)$]] }))
hl.bind(mod .. " + F11", hl.dsp.pass({ window = [[class:^(com\.obsproject\.Studio)$]] }))

-- Zoom --
hl.bind(
  mod .. " + minus",
  hl.dsp.exec_cmd(
    [[hyprctl getoption cursor:zoom_factor | grep float | awk '{ if($2!=1) system("hyprctl keyword cursor:zoom_factor " $2 - 0.1) }' && hyprctl getoption cursor:zoom_factor | grep float | awk '{print $2}']]
  ),
  { repeating = true }
)
hl.bind(
  mod .. " + equal",
  hl.dsp.exec_cmd(
    [[hyprctl getoption cursor:zoom_factor | grep float | awk '{ system("hyprctl keyword cursor:zoom_factor " $2 + 0.1) }' && hyprctl getoption cursor:zoom_factor | grep float | awk '{print $2}']]
  ),
  { repeating = true }
)

-- Notify when keyboard layout changes --
hl.bind(
  mod .. " + Space",
  hl.dsp.exec_cmd(
    [[notify-send -t 2000 "Layout" "$(hyprctl devices | grep -B 3 "main: yes" | grep "active keymap" | cut -d: -f2 | xargs)"]]
  )
)

-- Lock session --
hl.bind(mod .. " + backspace", hl.dsp.exec_cmd([[keepassxc --lock && hyprlock]]))

-- Lock password manager --
hl.bind(
  mod .. " + SHIFT + backspace",
  hl.dsp.exec_cmd([[keepassxc --lock && notify-send -t 2000 "KeepassXC" "Database locked"]])
)

-- Suspend the system when the laptop lid is closed --
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd([[suspend]]), { locked = true })

-- Toggle idling --
hl.bind(
  mod .. " + I",
  hl.dsp.exec_cmd(
    [[pgrep -x "hypridle" > /dev/null 2>&1 && { killall hypridle; notify-send -t 2000 "Idling" "Suspended"; } || { hypridle & disown; notify-send -t 2000 "Idling" "Resumed"; }]]
  )
)

-- Kill switch --
hl.bind(mod .. " + Escape", hl.dsp.exec_cmd([[doas /sbin/poweroff]]))
