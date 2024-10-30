Power = Entity:create {
  init = function(_ENV)
    levels = { 0, 0, 0, 0, 0, 0 }
  end,

  draw = function(_ENV)
    for c = 1, #colors do
      local cy, v, cc = c * 20, levels[c], colors[c]

      rect(121, cy - 20, 127, cy - 2, v == 3 and cc or 1)

      for idx = 1, levels[c] do
        rectfill(123, cy - idx * 5 - 2, 125, cy - idx * 5, cc)
      end
    end
  end,

  move = function(_ENV, c)
    levels[c] = (levels[c] + 1) % 4
  end,
}
