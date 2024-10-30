Power = Entity:create {
  level = 3,
  powers = { 1, 1, 1, 1, 1, 1 },
  init = function(_ENV)
    levels = { 0, 0, 0, 0, 0, 0 }
  end,

  draw = function(_ENV)
    for c = 1, #colors do
      if powers[c] ~= 0 then
        local cy, v, cc = c * 20, levels[c], colors[c]

        rect(121, cy - 20, 127, cy - 2, v == 3 and cc or 1)

        for idx = 1, levels[c] do
          rectfill(123, cy - idx * 5 - 2, 125, cy - idx * 5, cc)
        end
      end
    end
  end,

  move = function(_ENV, c)
    if powers[c] ~= 0 then
      levels[c] = (levels[c] + 1) % (level + 1)
    end
  end,

  active = function(_ENV, c)
    return levels[c] == level
  end,
}
