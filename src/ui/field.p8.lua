Field = Entity:create {
  size = 15,
  arena = 0,
  offset = -1,

  init = function(_ENV)
    if offset == -1 then
      offset = max((15 - size) * 8 / 2, 0)
    end
    ts = size > 15 and 6 or 8

    tiles = {}
    for n = 1, size * size do
      local t, h = Tile:new { n = n }
      add(tiles, t)

      if n % size ~= 1 then
        local f = tiles[n - 1] -- left
        add(t.hvrel, f.n)
        add(f.hvrel, n)
      end
      if n > size then
        local up = n - size
        local f = tiles[up] -- up
        add(t.hvrel, f.n)
        add(f.hvrel, n)

        if n % size ~= 1 then
          local f = tiles[up - 1] -- up-left
          add(t.diag, f.n)
          add(f.diag, n)
        end
        if n % size ~= 0 then
          local f = tiles[up + 1] -- up-right
          add(t.diag, f.n)
          add(f.diag, n)
        end
      end
    end

    if arena ~= 0 then
      local data = ARENAS[arena]
      for n = 2, #data do
        local t = tiles[data[n]]
        t.c = 0
        t.p = 5
      end
    end
  end,

  draw = function(_ENV)
    foreach(tiles, function(t)
      _ENV:draw_tile(t.n, COLORS[t.c] or 1)
    end)
  end,

  draw_tile = function(_ENV, n, c)
    local t = tiles[n]
    local x, y = _ENV:tile_coords(n, size, offset, ts)
    if (t.p == 0) then
      rectfill(x, y, x + ts - 2, y + ts - 2, c)
    else
      rect(x, y, x + ts - 2, y + ts - 2, c or 1)
    end
  end,

  tile_coords = function(_ENV, n)
    local idx = n - 1
    return idx % size * ts + offset, idx \ size * ts + offset
  end,
}
