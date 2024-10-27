function show_brief(mission)
  music(-1)
  frame()

  -- setup menu
  menuitem(1, "restart mission ", function()
    show_brief(mission)
  end)

  dset(cdata.mission, mission - 1)

  -- reset campaign data
  if mission == 1 then
    dset(cdata.time, 0)
    dset(cdata.score, 0)
  end

  scene = {
    -- title
    typewriter:new {
      txt = "mission " .. mission .. ' "' .. missions[mission].n .. '"',
      speed = 3,
    },

    -- information
    typewriter:new {
      txt = briefs[mission],
      speed = 1,
      y = 32,
      c = 6,
    },

    -- confirm
    confirmation:new {
      txt = "confirm",
      callback = function()
        show_mission(mission)
      end,
    },
  }
end
