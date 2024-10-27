cartdata "horneds-sw"
cdata =
  load_table_str "done=0,palette=1,mission=2,place=3,practice=4,arena=5,score=6,time=7,mscores=10,ascores=50"

function init()
  init_palette(function()
    return dget(cdata.palette) == 1
  end, function(alt)
    dset(cdata, alt and 1 or 0)
  end)
  show_start()
  -- show_brief(5)
  -- show_mission(0, 2, 6, 20)
  -- show_results(#missions, 1, 8, 0, 0, true)
  -- show_gameover()
  -- show_practice()
  -- show_debug()
end
