function init_palette(getter, setter)
  local alt = getter()
  toggle_pallete(alt)
  menuitem(2, "toggle pallete", function()
    alt = not alt
    setter(alt)
    toggle_pallete(alt)
  end)
end

function toggle_pallete(alt)
  for i = 1, 15 do
    pal(i, i + (alt and 128 or 0), 1)
  end
end
