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
        add(t.hvrel, f)
        add(f.hvrel, t)
      end
      if n > size then
        local up = n - size
        local f = tiles[up] -- up
        add(t.hvrel, f)
        add(f.hvrel, t)

        if n % size ~= 1 then
          local f = tiles[up - 1] -- up-left
          add(t.diag, f)
          add(f.diag, t)
        end
        if n % size ~= 0 then
          local f = tiles[up + 1] -- up-right
          add(t.diag, f)
          add(f.diag, t)
        end
      end
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
}
