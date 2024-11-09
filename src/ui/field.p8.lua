Fd = Ent:create {
  s = 20,
  o = nil,
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

    foreach(t, function(tt)
        fix_color(tt, t)
    end)

    if o then
      local prv
      for p, v in ipairs(o) do
        for i, h in ipairs(split(v)) do
          if h == "" then break end
          local tt = t[tonum("0x" .. h)]
          tt.t = p + 1
          if p == 1 and i % 2 == 0 then
            prv.c = tt.c
          end
          prv = tt
        end
      end
    end

    if a then
      for h in all(split(ARENAS[a][2])) do
        if h == "" then break end
        local tt = t[tonum("0x" .. h)]
        if tt.t == 0 then
          tt.c = 1
          tt.p = 5
        end
      end
    end
  end,

  draw = function(_ENV)
    foreach(t, function(t)
      t:draw(s, off, ts)
    end)
  end,

  draw_dark = function(_ENV)
    foreach(t, function(pt)
      if pt.p == 1 then
        pt:draw(s, off, ts)
      end
      for n in all(pt.hvrel) do
        local ft = t[n]
        if ft.p == 1 then
          pt:draw(s, off, ts)
        end
      end
      for n in all(pt.diag) do
        local ft = t[n]
        if ft.p == 1 then pt:draw(s, off, ts) end
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

function fix_color(tt, t)
  for n in all(tt.hvrel) do
    local c = t[n].c
    if c == tt.c then
      return
    end
  end
  tt.c = rndcolor()
end
