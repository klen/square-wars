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
    dset(CDATA.power, 0)
  end

  local power, mdata = dget(CDATA.power), MISSIONS[mission]
  power = power & (mdata.w or 0)

  SCENE = {
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

    -- powers
    power > 0
        and Entity:new {
          draw = function()
            for c = 1, #COLORS do
              if power & (1 << (c - 1)) > 0 then
                circ(128 - (c * 5), 100, 1, COLORS[c])
              end
            end
          end,
        }
      or nil,

    -- confirm
    Confirmation:new {
      txt = "confirm",
      callback = function()
        show_mission(mission)
      end,
    },
  }
end
