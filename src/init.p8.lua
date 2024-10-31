cartdata "horneds-sw-1"

function init()
  init_palette(function()
    return dget(CDATA.palette) == 1
  end, function(alt)
    dset(CDATA.palette, alt and 1 or 0)
  end)
  show_start()
end
