function rndcolor()
  return rnd(COLORS)
end

TPS = split ",☉,✽,◆,♥,⧗,❎"

Tile = Ent:create {
  n = 0,
  p = 0,
  t = 0,

  init = function(_ENV)
    c = rndcolor()
    diag = {} -- diagonal
    hvrel = {} -- horizontal and vertical
  end,

  draw = function(_ENV, sz, of, ts)
    local idx = n - 1
    local x, y = idx % sz * ts + of, idx \ sz * ts + of
    if p > 0 then
      rect(x, y, x + ts - 2, y + ts - 2, c)
    elseif t == 0 then
      rectfill(x, y, x + ts - 2, y + ts - 2, c)
    else
      print(TPS[t], x - 1, y, c)
      rect(x-1, y-1, x - 1 + ts, y - 1 + ts, 0)
    end
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
    if t.p == 0 and t.c == c then
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
