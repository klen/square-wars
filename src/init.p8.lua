cartdata "horneds-sw-3"

function _init()
  init_palette(function()
    return dget(CART.palette) == 1
  end, function(alt)
    dset(CART.palette, alt and 1 or 0)
  end)
  splash()
  -- brief(1)
  log "\n--------------------------"
end
