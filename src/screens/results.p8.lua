function show_results(players, moves, seconds, num, mode)
  frame()

  local r = report(#players > 1 and players or {}, moves, seconds, num, mode)

  -- practice mode
  if mode == "m" then
    local place = find(players, function(p)
      return not p.cpu
    end)

    -- mission lost (update campaign stats)
    dset(cdata.place, place)
    dset(cdata.time, dget(cdata.time) + seconds)

    if place ~= 1 then
      scene = {
        r(),
        typewriter:new { txt = "status: disqualified", c = 8, y = 95 },
        confirmation:new { txt = "main menu", callback = show_start },
      }
    -- mission won
    else
      -- update mission data
      dset(cdata.mission, num)
      dset(cdata.score, dget(cdata.score) + players[place].s)

      local mdata = missions[num]
      local unlock = mdata.u
      if unlock then
        dset(cdata[unlock], dget(cdata[unlock]) + 1)
      end

      scene = {
        r(),
        typewriter:new { txt = "status: mission complete", c = 12, y = 95 },
        mdata.un and typewriter:new { txt = "unlocked: " .. mdata.un, c = 6, y = 82 } or nil,
        confirmation:new {
          txt = "confirm",
          callback = num == #missions and show_gameover or function()
            show_brief(num + 1)
          end,
        },
      }
    end
  else
    scene = {
      r(),
      confirmation:new { txt = "main menu", callback = show_start },
    }
  end
end
