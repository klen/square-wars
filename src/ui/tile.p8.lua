function rndcolor(free)
  return flr(rnd(#COLORS) + 1)
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
function cluster(t)
  local res, seen, q, c = {}, { [t.n] = true }, { t }, t.c
  while #q > 0 do
    local t = q[1]
    deli(q, 1)
    if t.p == 0 and t.c == c then
      add(res, t)
      for f in all(t.hvrel) do
        if not seen[f.n] then
          seen[f.n] = true
          add(q, f)
        end
      end
    end
  end
  res = sort(res, function(a, b)
    return a.n > b.n
  end)
  return res
end
