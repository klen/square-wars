function rndcolor()
  return rint(#COLORS, 1)
end

TPS = split ",☉,✽,◆,♥,⧗"

Tile = Ent:create {
  n = 0,
  p = nil,
  tp = nil,

  init = function(_ENV)
    diag = {}
    hvrel = {}
    c = rndcolor()
  end,

  draw = function(_ENV, sz, of, ts)
    local i, cl = n - 1, COLORS[c] or 1
    local x, y = i % sz * ts + of, i \ sz * ts + of
    if tp and tp > 1 then
      if TPS[tp] then
        print(TPS[tp] or '', x - 1, y, cl)
        rect(x-1, y-1, x - 1 + ts, y - 1 + ts, 0)
      end
    elseif p then
      rect(x, y, x + ts - 2, y + ts - 2, cl)
    else
      rectfill(x, y, x + ts - 2, y + ts - 2, cl)
    end
  end,

  boom = function(_ENV)
    p, tp, c = 5, 0, nil
  end,
}

-- find free tiles same color
function cluster(tn, tiles)
  local q, seen, res = { tn }, { [tn] = true }, {}
  local c = tiles[tn].c

  while #q > 0 do
    local qn = q[1]
    deli(q, 1)

    local t = tiles[qn]
    if not t.p and t.c == c then
      add(res, qn)
      for fn in all(t.hvrel) do
        if not seen[fn] then
          seen[fn] = true
          add(q, fn)
        end
      end
    end
  end
  return sort(res, function(a, b)
    return a > b
  end)
end
