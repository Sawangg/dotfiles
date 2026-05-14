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
