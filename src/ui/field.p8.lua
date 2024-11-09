Fd = Ent:create {
  s = 20,
  a = nil,
  eff = nil,

  init = function(_ENV)
    if eff == 'dark' then
      draw = draw_dark
    else
      draw = draw
    end
    if not off then
      off = max((15 - s) * 8 / 2, 0)
    end
    ts = s > 15 and 6 or 8

    t = {}
    for n = 1, s * s do
      local tt = Tile:new { n = n }
      add(t, tt)

      if n % s ~= 1 then
        local ft = t[n - 1] -- left
        add(tt.hvrel, ft.n)
        add(ft.hvrel, n)
      end
      if n > s then
        local up = n - s
        local ft = t[up] -- up
        add(tt.hvrel, ft.n)
        add(ft.hvrel, n)

        if n % s ~= 1 then
          local ft = t[up - 1] -- up-left
          add(tt.diag, ft.n)
          add(ft.diag, n)
        end
        if n % s ~= 0 then
          local ft = t[up + 1] -- up-right
          add(tt.diag, ft.n)
          add(ft.diag, n)
        end
      end
    end

    if a then
      for n = 2, #ARENAS[a] do
        local tt = t[ARENAS[a][n]]
        tt.c = 1
        tt.p = 5
      end
    end
  end,

  draw = function(_ENV)
    foreach(t, function(t)
      _ENV:draw_tile(t.n, t.c)
    end)
  end,

  draw_tile = function(_ENV, n, c)
    local t = t[n]
    local x, y = _ENV:tile_coords(n, s, off, ts)
    if (t.p == 0) then
      rectfill(x, y, x + ts - 2, y + ts - 2, c)
    else
      rect(x, y, x + ts - 2, y + ts - 2, c or 1)
    end
  end,

  draw_dark = function(_ENV)
    foreach(t, function(pt)
      if pt.p == 1 then
        return _ENV:draw_tile(pt.n, pt.c)
      end
      for n in all(pt.hvrel) do
        local ft = t[n]
        if ft.p == 1 then
          return _ENV:draw_tile(pt.n, pt.c)
        end
      end
      for n in all(pt.diag) do
        local ft = t[n]
        if ft.p == 1 then
          return _ENV:draw_tile(pt.n, pt.c)
        end
      end
    end)
  end,

  tile_coords = function(_ENV, n)
    local idx = n - 1
    return idx % s * ts + off, idx \ s * ts + off
  end,

  move = function(_ENV)
    if eff == 'erosion' then
      local tc = rnd(t)
      if tc.p == 0 then
        tc.c = 1
        tc.p = 5
      end
    end
  end,
}
