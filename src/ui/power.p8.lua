Power = Entity:create {
  charge = 4,
  powers = 0b111111,

  init = function(_ENV)
    levels = split "4,4,4,4,4,4"
  end,

  draw = function(_ENV)
    for c = 1, #COLORS do
      if powers & (1 << (c - 1)) > 0 then
        local cy, v, cc = c * 20, levels[c], COLORS[c]
        rect(121, cy - 20, 127, cy - 2, v == charge and cc or 1)

        for idx = 1, levels[c] do
          rectfill(123, cy - idx * 4 - 2, 125, cy - idx * 4, cc)
        end
      end
    end
  end,

  move = function(_ENV, c)
    if powers & (1 << (c - 1)) > 0 then
      levels[c] = (levels[c] + 1) % (charge + 1)
    end
  end,

  active = function(_ENV, c)
    return levels[c] == charge
  end,
}
