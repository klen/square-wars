field = entity:create {
  size = 15,
  arena = 0,
  offset = -1,

  init = function(_ENV)
    if offset == -1 then
      offset = max((15 - size) * 8 / 2, 0)
    end

    tiles = {}
    for n = 1, size * size do
      add(tiles, {
        p = 0,
        n = n,
        c = rndcolor(),
      })
    end

    if arena ~= 0 then
      local data = arenas[arena]
      for n = 2, #data do
        local t = tiles[data[n]]
        t.c = 0
        t.p = 5
      end
    end
  end,

  draw = function(_ENV)
    foreach(tiles, function(t)
      draw_tile(t, size, offset)
    end)
  end,

  get_neighbours = function(_ENV, st)
    local n, res, t = st.n, {}, nil

    if n % size ~= 1 then
      t = tiles[n - 1]
      if t.p == 0 then
        add(res, t)
      end
    end
    if n % size ~= 0 then
      t = tiles[n + 1]
      if t.p == 0 then
        add(res, t)
      end
    end
    if n > size then
      t = tiles[n - size]
      if t.p == 0 then
        add(res, t)
      end
    end
    if size * size - size >= n then
      t = tiles[n + size]
      if t.p == 0 then
        add(res, t)
      end
    end

    return res
  end,
}

function rndcolor(free)
  return flr(rnd(#colors) + 1)
end
