function show_results(players, moves, seconds, num, mode)
  frame()

  local r = report(#players > 1 and players or {}, moves, seconds, num, mode)

  -- practice mode
  if mode == "m" then
    local place = find(players, function(p)
      return not p.cpu
    end)

    -- mission lost (update campaign stats)
    dset(CDATA.place, place)
    dset(CDATA.time, dget(CDATA.time) + seconds)

    if place ~= 1 then
      SCENE = {
        r(),
        Typewriter:new { txt = "status: disqualified", c = 8, y = 95 },
        Confirmation:new { txt = "main menu", callback = show_start },
      }
    -- mission won
    else
      -- update mission data
      dset(CDATA.mission, num)
      dset(CDATA.score, dget(CDATA.score) + players[place].score)

      local mdata = MISSIONS[num]
      local unlock, unlock_value = mdata.u, mdata.uv
      if unlock then
        dset(CDATA[unlock], unlock_value and unlock_value or (dget(CDATA[unlock]) + 1))
      end

      SCENE = {
        r(),
        Typewriter:new { txt = "status: mission complete", c = 12, y = 95 },
        mdata.un and Typewriter:new { txt = "unlocked: " .. mdata.un, c = 6, y = 82 } or nil,
        Confirmation:new {
          txt = "confirm",
          callback = num == #MISSIONS and show_gameover or function()
            show_brief(num + 1)
          end,
        },
      }
    end
  else
    SCENE = {
      r(),
      Confirmation:new { txt = "main menu", callback = show_start },
    }
  end
end
