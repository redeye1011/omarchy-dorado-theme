-- Dorado (Stormfront): ice -> storm -> gold -> ice border that drifts slowly like
-- ionised gas, soft "condense" window entry, and 0.95/0.88 focus depth.

local active_border_color = {
  colors = { "rgba(ff9447ee)", "rgba(e8a35aee)", "rgba(b7d6e6ee)", "rgba(ff9447ee)" },
  angle = 45,
}
local inactive_border_color = "rgba(1f2735cc)"

hl.curve("condense", { type = "bezier", points = { { 0.22, 1.00 }, { 0.36, 1.00 } } }) -- gas settling into place
hl.curve("drift",    { type = "bezier", points = { { 0.00, 0.00 }, { 1.00, 1.00 } } }) -- constant rotation

hl.config({
  general = {
    col = {
      active_border = active_border_color,
      inactive_border = inactive_border_color,
    },
    gaps_in = 4,
    gaps_out = 6,
    border_size = 2,
  },

  group = {
    col = {
      border_active = active_border_color,
      border_inactive = inactive_border_color,
    },
  },

  decoration = {
    rounding = 10,
    shadow = {
      enabled = false,
    },
  },

  misc = {
    background_color = "rgb(07090e)",
  },
})

hl.animation({ leaf = "borderangle", enabled = true, speed = 60,  bezier = "drift",    style = "loop" })
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 4.0, bezier = "condense", style = "popin 94%" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 2.6, bezier = "condense", style = "popin 96%" })
hl.animation({ leaf = "fadeIn",      enabled = true, speed = 3.0, bezier = "condense" })
hl.animation({ leaf = "fadeOut",     enabled = true, speed = 2.4, bezier = "condense" })

-- Focus depth: focused windows near-solid, unfocused ones let the nebula through.
o.window({ tag = "default-opacity" }, { opacity = "0.95 0.88" })

-- Terminals and GTK apps already dim through their own 0.93 background alpha
-- (ghostty.conf, foot.ini, gtk.css); only a light extra dim when unfocused.
o.window("^(com\\.mitchellh\\.ghostty|foot|footclient|org\\.gnome\\..*|org\\.pulseaudio\\.pavucontrol)$", { opacity = "1 0.95" })
