function game(fd, jd, pwr, plw)
  music(-1)
  sfx(56)
  cls()

  local f, w = Fld:new(fd), pwr and Power:new { pwr = pwr, plw = plw or dget(CART.power) } or nil
  jd.f = f
  jd.pwr = w
  local j = Judge:new(jd)

  pause()

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
