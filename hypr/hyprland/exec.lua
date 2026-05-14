local programs = require("hyprland.programs")

hl.on("hyprland.start", function()
  hl.exec_cmd("quickshell") -- Shell desktop
  hl.exec_cmd("hypridle") -- Idle daemon
  hl.exec_cmd("hyprpaper") -- Wallpaper daemon
  hl.exec_cmd("dbus-update-activation-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP") -- Used for desktop portal

  -- Automatically open apps in the order I like
  hl.exec_cmd(programs.browser, { workspace = "1 silent" })
  hl.exec_cmd(programs.terminal, { workspace = "2 silent" })
  hl.exec_cmd(programs.password_manager, { workspace = "10 silent" })
end)
