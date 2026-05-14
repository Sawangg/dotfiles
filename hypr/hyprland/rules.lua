-- Prevent any app from maximizing and taking focus --
hl.window_rule({
  match = { class = ".*" },
  suppress_event = "maximize",
})

-- Prevent idle when any app is full screen --
hl.window_rule({
  match = { class = ".*" },
  idle_inhibit = "fullscreen",
})

-- Disable animations for launchers --
hl.layer_rule({
  match = { namespace = "launcher" },
  no_anim = true,
})

-- Force KeePassXC to workspace 10 and disable screen sharing --
hl.window_rule({
  match = { class = "org.keepassxc.KeePassXC" },
  workspace = "10 silent",
  no_screen_share = true,
})

-- KeePassXC unlock dialog stays on current workspace --
hl.window_rule({
  match = { title = "Unlock Database - KeePassXC" },
  workspace = "unset",
})

-- Focus on KeePassXC dialog on current workspace --
hl.window_rule({
  match = { title = "Unlock Database - KeePassXC" },
  pin = true,
  stay_focused = true,
  center = true,
})

-- Change border color of pinned windows --
hl.window_rule({
  match = { pin = true },
  border_color = "rgba(FFB2BCAA) rgba(FFB2BC77)",
})

-- Smart gaps --
hl.workspace_rule({
  workspace = "w[tv1]",
  gaps_out = 0,
  gaps_in = 0,
})

hl.workspace_rule({
  workspace = "f[1]",
  gaps_out = 0,
  gaps_in = 0,
})

hl.window_rule({
  match = { float = false, workspace = "w[tv1]" },
  border_size = 0,
  rounding = 0,
})

hl.window_rule({
  match = { float = false, workspace = "f[1]" },
  border_size = 0,
  rounding = 0,
})

-- Picture-in-picture --
hl.window_rule({
  name = "picture-in-picture",
  match = { title = [[^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$]] },
  float = true,
  center = true,
  idle_inhibit = "always",
  size = {
    "(monitor_w*0.2)",
    "(monitor_w*0.2*0.5625)",
  },
})

-- Allow tearing for cs2 --
hl.window_rule({
  match = { class = "cs2" },
  immediate = true,
})
