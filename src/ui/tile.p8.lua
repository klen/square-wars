function rndcolor()
  return rnd(COLORS)
end

Tile = Entity:create {
  n = 0,
  p = 0,

  init = function(_ENV)
    c = rndcolor()
    diag = {} -- diagonal
    hvrel = {} -- horizontal and vertical
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
