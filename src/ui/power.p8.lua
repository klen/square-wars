Power = Ent:create {
  mx = 4,
  plw = 0,
  pwr = 0b111111,

  init = function(_ENV)
    lvl = split "0,0,0,0,0,0"
  end,

  draw = function(_ENV)
    for i = 1, #COLORS do
      local px = 1 << (i - 1)
      if pwr & px > 0 then
        local cy, v, cc = i * 20, lvl[i], COLORS[i]
        rect(121, cy - 20, 127, cy - 2, v == mx and cc or plw & px > 0 and 1 or 2)

        for i = 1, lvl[i] do
          rectfill(123, cy - i * 4 - 2, 125, cy - i * 4, cc)
        end
      end
    end
  end,

  register = function(_ENV, c)
    local i = c - 6
    if pwr & (1 << (i - 1)) > 0 then
      lvl[i] = (lvl[i] + 1) % (mx + 1)
    end
  end,

  active = function(_ENV, c)
    return lvl[c - 6] == mx
  end,
}
