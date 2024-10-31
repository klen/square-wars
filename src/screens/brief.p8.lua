function show_brief(mission)
  music(-1)
  frame()

  -- setup menu
  menuitem(1, "restart mission ", function()
    show_brief(mission)
  end)

  -- reset campaign data
  if mission == 1 then
    dset(CDATA.time, 0)
    dset(CDATA.score, 0)
  end

  scene = {
    -- title
    Typewriter:new {
      txt = "mission " .. mission .. ' "' .. MISSIONS[mission].n .. '"',
      speed = 3,
    },

    -- information
    Typewriter:new {
      y = 24,
      c = 6,
      speed = 1,
      txt = BRIEFS[mission],
    },

    -- confirm
    Confirmation:new {
      txt = "confirm",
      callback = function()
        show_mission(mission)
      end,
    },
  }
end
