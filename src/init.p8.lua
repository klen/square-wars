cartdata "horneds-sw-3"

local palette

function _init()
  palette()
  menuitem(3, "unlock all", function()
    dset(CART.done, 1)
    dset(CART.power, 63)
    dset(CART.arena, #ARENAS)
    sfx(59)
    start()
  end)
  menuitem(4, "erase savestate", function()
    menuitem(nil, "erase savestate?", function()
      for idx = 0, 63 do
        dset(idx, 0)
      end
      sfx(59)
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
    sfx(59)
    palette((plt + 1) % 2)
  end)
end

function toggle_pallete(alt)
  for i = 1, 15 do
    pal(i, i + (alt == 1 and 128 or 0), 1)
  end
end
