cartdata "horneds-sw-3"

local palette

function _init()
  palette()
  menuitem(3, "unlock all", function()
    dset(CART.done, 1)
    dset(CART.power, 63)
    dset(CART.arena, #ARENAS)
    beep()
    start()
  end)
  menuitem(4, "erase savestate", function()
    menuitem(nil, "erase savestate?", function()
      for k, v in pairs(CART) do
        dset(CART[k], 0)
      end
      beep()
      _init()
      start()
    end)
    return true
  end)

  splash()
end

palette = function(plt)
  plt = plt or dget(CART.palette)
  toggle_pallete(plt)
  dset(CART.palette, plt)
  menuitem(2, "toggle pallet: " .. tostr(plt + 1), function()
    beep()
    palette((plt + 1) % 2)
  end)
end

function toggle_pallete(alt)
  for i = 1, 15 do
    pal(i, i + (alt == 1 and 128 or 0), 1)
  end
end
