Fd = Ent:create {
  s = 20,
  o = nil,
  a = nil,
  eff = nil,

  init = function(_ENV)
    if eff == "dark" then
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
      local tt = Tile:new {
        n = n,
        ts = ts,
        x = (n - 1) % s * ts + off,
        y = (n - 1) \ s * ts + off,
      }
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
      fix_tile(t, tt)
    end)

    if o then
      local prv
      for tp, v in pairs(o) do
        for i, h in ipairs(split(v)) do
          if h == "" then
            break
          end
          local tt = t[tonum("0x" .. h)]
          tt.tp = tp
          while tt.c == #COLORS do
            tt.c = rndcolor()
          end
          if tp == 3 and i % 2 == 0 then
            prv.c = tt.c
          end
          prv = tt
        end
      end
    end

    if a then
      for h in all(split(ARENAS[a][2])) do
        if h == "" then
          break
        end
        local tt = t[tonum("0x" .. h)]
        if not tt.tp then
          tt.tp = 1
          tt.av = false
        end
      end
    end
  end,

  draw = function(_ENV)
    foreach(t, function(t)
      t:draw()
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
        if ft.p == 1 then
          pt:draw(s, off, ts)
        end
      end
    end)
  end,

  move = function(_ENV)
    if eff == "erosion" then
      local tc = rnd(t)
      tc:boom()
    end
  end,
}

function fix_tile(t, tt)
  local cl, idx = cluster(tt.n, t), #COLORS
  while idx > 0 and (#cl > 4 or #cl == 1) do
    tt.c = rndcolor()
    cl = cluster(tt.n, t)
    idx -= 1
  end
end

function get_clusters(targets, tiles)
  local seen, clusters = {}, { {}, {}, {}, {}, {}, {}, {} }
  for tn in all(targets) do
    local cl = cluster(tn, tiles)
    local cnum = cl[1]
    if not seen[cnum] then
      seen[cnum] = true
      local t = tiles[tn]
      for cn in all(cl) do
        add(clusters[t.c], cn)
      end
    end
  end
  clusters = sort(clusters, function(a, b)
    return #a > #b
  end)
  return filter(clusters, function(c)
    return #c > 0
  end)
end
