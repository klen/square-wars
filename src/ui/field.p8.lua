Field = Entity:create {
  size = 15,
  arena = 0,
  offset = -1,

  init = function(_ENV)
    if offset == -1 then
      offset = max((15 - size) * 8 / 2, 0)
    end

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
      draw_tile(t, size, offset)
    end)
  end,
}

function draw_tile(t, size, offset)
  local idx = t.n - 1
  local s = size > 15 and 6 or 8
  local x, y = idx % size * s + offset, idx \ size * s + offset
  if (t.p == 0) then
    rectfill(x, y, x + s - 2, y + s - 2, COLORS[t.c])
  else
    rect(x, y, x + s - 2, y + s - 2, COLORS[t.c] or 1)
  end
end
