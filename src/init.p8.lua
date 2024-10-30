cartdata "horneds-sw"
cdata =
  load_table_str "done=0,palette=1,mission=2,place=3,practice=4,arena=5,score=6,time=7,mute=8,power=9,mscores=10,ascores=50"

function init()
  init_palette(function()
    return dget(cdata.palette) == 1
  end, function(alt)
    dset(cdata, alt and 1 or 0)
  end)
  show_start()
end
