function show_results(num, place, score, moves, seconds, mission)
  frame()

  local dkey = mission and cdata.mscores - 1 or cdata.ascores - 1

  local tscore, rscore, rnum = dget(dkey + num), score, mission and "m" .. num or "a" .. num
  if score > tscore then
    dset(dkey + num, score)
    if tscore > 0 then
      rscore = score .. " (" .. rnum .. " top)"
    end
  end
  local r = report(place, rscore, moves, seconds, rnum)

  -- practice mode
  if not mission then
    scene = {
      r(),
      confirmation:new { txt = "main menu", callback = show_start },
    }
  else
    dset(cdata.place, place)
    -- mission lost
    if place ~= 1 then
      scene = {
        r(),
        typewriter:new { txt = "status: disqualified", c = 8, y = 84 },
        confirmation:new { txt = "main menu", callback = show_start },
      }
    -- mission won
    else
      local mdata = missions[num]
      local unlock = mdata.u
      if unlock then
        dset(cdata[unlock], dget(cdata[unlock]) + 1)
      end
      dset(cdata.mission, num)
      dset(cdata.time, dget(cdata.time) + seconds)
      dset(cdata.score, dget(cdata.score) + score)

      scene = {
        r(),
        typewriter:new { txt = "status: mission complete", c = 12, y = 86 },
        mdata.un and typewriter:new { txt = "unlocked: " .. mdata.un, c = 6, y = 74 } or nil,
        confirmation:new {
          txt = "confirm",
          callback = num == #missions and show_gameover or function()
            show_brief(num + 1)
          end,
        },
      }
    end
  end
end
