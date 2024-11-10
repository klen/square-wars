function game(fd, jd, pwr)
  music(-1)
  sfx(0)
  cls()

  local f, w = Fd:new(fd), pwr and Power:new { pwr = pwr, plw = dget(CART.power) } or nil
  jd.f = f
  jd.pwr = w
  local j = Judge:new(jd)

  SCENE = {
    art(cls),
    -- field
    f,
    -- judge
    j,
    -- power
    w,
    -- controls
    Ctrl:new { jd = j, pwr = w },
  }

  frz:freeze(80, Fade:new { rev = true, fr = 60 })
end
