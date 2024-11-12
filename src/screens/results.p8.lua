function results(players, moves, seconds, num, mode, seed)
  pal(0)
  frame()

  local win, r =
    players[1], report(#players > 1 and players or {}, moves, seconds, num, seed and "r" or mode)
  SCENE = { r() }

  if seed then
    if win.cpu then
      add(SCENE, Tw:new { txt = "status: run over (" .. dget(CART.run) .. ")", c = 8, y = 95 })
      add(SCENE, Conf:new { txt = "main menu", cb = start })
    else
      local run, runmax = dget(CART.run) + 1, dget(CART.runmax)
      dset(CART.rscore, dget(CART.rscore) + win.score)
      dset(CART.run, run)
      dset(CART.runmax, max(runmax, run))
      if run > runmax then
        add(SCENE, Tw:new { txt = "max run updated!", c = 10, y = 95 })
      end
      add(
        SCENE,
        Conf:new {
          txt = "continue",
          cb = part(infinite, seed),
        }
      )
    end
  elseif mode == "m" then
    dset(CART.time, dget(CART.time) + seconds)

    if win.cpu then
      add(SCENE, Tw:new { txt = "status: disqualified", c = 8, y = 95 })
      add(SCENE, Conf:new { txt = "main menu", cb = start })
    else
      local mdata = MISSIONS[num]
      local done = mdata.r or num
      dset(CART.mission, done)
      dset(CART.score, dget(CART.score) + win.score)

      add(SCENE, Tw:new { txt = "status: mission complete", c = 12, y = 95 })
      add(SCENE, unlock(mdata))
      add(
        SCENE,
        Conf:new {
          txt = "confirm",
          cb = num == #MISSIONS and gameover or part(brief, done + 1),
        }
      )
    end
  else
    add(SCENE, Conf:new { txt = "main menu", cb = start })
  end
end
