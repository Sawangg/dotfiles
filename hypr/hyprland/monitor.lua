hl.monitor({
  output = "DP-1",
  mode = "preferred",
  position = "0x0",
  scale = 1.25,
  bitdepth = 10,
  supports_wide_color = true,
  supports_hdr = true,
})

hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto",
  scale = 1,
  mirror = "DP-1",
})

-- scale monitors based on their resolution
local function apply_scale(monitor)
  if monitor.is_mirror then
    return
  end

  local desired = 1.25
  if monitor.width == 1920 and monitor.height == 1080 then
    desired = 1
  end

  if monitor.scale ~= desired then
    hl.monitor({ output = monitor.name, scale = desired })
  end
end

hl.on("monitor.added", function(m)
  apply_scale(m)
end)

hl.on("monitor.layout_changed", function()
  for _, m in ipairs(hl.get_monitors()) do
    apply_scale(m)
  end
end)

hl.on("hyprland.start", function()
  for _, m in ipairs(hl.get_monitors()) do
    apply_scale(m)
  end
end)
