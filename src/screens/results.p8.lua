function results(players, moves, seconds, num, mode)
  frame()

  local r = report(#players > 1 and players or {}, moves, seconds, num, mode)

  -- practice mode
  if mode == "m" then
    local win = players[1]
    dset(CART.time, dget(CART.time) + seconds)

    if win.cpu then
      SCENE = {
        r(),
        Tw:new { txt = "status: disqualified", c = 8, y = 95 },
        Conf:new { txt = "main menu", cb = start },
      }
    else
      local mdata = MISSIONS[num]
      local done = mdata.r or num
      dset(CART.mission, done)
      dset(CART.score, dget(CART.score) + win.score)

      SCENE = {
        r(),
        Tw:new { txt = "status: mission complete", c = 12, y = 95 },
        unlock(MISSIONS[num]),
        Conf:new {
          txt = "confirm",
          cb = num == #MISSIONS and gameover or function()
            brief(done + 1)
          end,
        },
      }
    end
  else
    SCENE = {
      r(),
      Conf:new { txt = "main menu", cb = start },
    }
  end
end
