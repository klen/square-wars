Power = Entity:create {
  charge = 4,
  powers = 0b111111,

  init = function(_ENV)
    levels = split "0,0,0,0,0,0"
  end,

  draw = function(_ENV)
    for idx = 1, #COLORS do
      if powers & (1 << (idx - 1)) > 0 then
        local cy, v, cc = idx * 20, levels[idx], COLORS[idx]
        rect(121, cy - 20, 127, cy - 2, v == charge and cc or 1)

        for idx = 1, levels[idx] do
          rectfill(123, cy - idx * 4 - 2, 125, cy - idx * 4, cc)
        end
      end
    end
  end,

  move = function(_ENV, idx)
    if powers & (1 << (idx - 1)) > 0 then
      levels[idx] = (levels[idx] + 1) % (charge + 1)
    end
  end,

  active = function(_ENV, idx)
    return levels[idx] == charge
  end,
}
