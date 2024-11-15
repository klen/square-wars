function rndcolor()
  return rint(#COLORS, 1)
end

draw_plr = function(x, y, ts, c)
  rect(x, y, x + ts - 2, y + ts - 2, c)
end

-- WLL: 1, EMT: 2, PRT: 3, BMB: 4
OBS = { [3] = "☉", [4] = "✽" }

Tile = Ent:create {
  av = true,
  n = 0,
  x = 0,
  y = 0,
  ts = 8,
  -- p = nil,
  -- tp = nil,

  init = function(_ENV)
    diag, hvrel, c = {}, {}, rndcolor()
  end,

  draw = function(_ENV)
    local cl = COLORS[c] or 1

    if p then
      draw_plr(x, y, ts, cl)
    elseif not tp then
      rectfill(x, y, x + ts - 2, y + ts - 2, cl)
    elseif tp == 1 then
      draw_plr(x, y, ts, 1)
    elseif tp > 2 then
      print(OBS[tp] or "", x - 1, y, cl)
      rect(x - 1, y - 1, x - 1 + ts, y - 1 + ts, 0)
    end
  end,

  free = function(_ENV, _c)
    return not p and av and (not _c or c == _c)
  end,

  boom = function(_ENV)
    _ENV:anim(c, 0)
    p, tp, c, av = nil, 2, nil, false
  end,

  anim = function(_ENV, cl, min)
    add(frz.es, atile(x, y, ts, COLORS[c], cl, min))
  end,
}

function atile(x, y, ts, cn, cp, min)
  local fr = 11
  min = min or -10
  return {
    update = function()
      if fr > min then
        fr -= 1
      end
    end,
    draw = function()
      local d = 10 - abs(fr)
      local h = ts / 20 * d
      if fr >= 0 then
        rectfill(x, y, x + ts - 2, y + ts - 2, cp)
      else
        draw_plr(x, y, ts, cn)
      end
      rectfill(x, y, x + ts - 1, y + h, 0)
      rectfill(x, y + ts - h - 1, x + ts - 1, y + ts - 1, 0)
    end,
  }
end

-- find free tiles same color
function cluster(tn, tiles)
  local q, seen, res = { tn }, { [tn] = true }, {}
  local c = tiles[tn].c

  while #q > 0 do
    local qn = q[1]
    deli(q, 1)

    local t = tiles[qn]
    if t:free(c) then
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
