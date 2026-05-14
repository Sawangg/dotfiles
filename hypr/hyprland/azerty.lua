-- French keyboard binds --
local mod = "SUPER"

for workspace, key in ipairs({
  "ampersand",
  "eacute",
  "quotedbl",
  "apostrophe",
  "parenleft",
  "egrave",
  "minus",
  "underscore",
  "ccedilla",
  "agrave",
}) do
  hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
  hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }))
end

hl.config({
  input = {
    kb_layout = "fr,us",
  },
})
