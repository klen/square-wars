-- globals: colors
--
Ctrl = Ent:create {
  sc = 7,
  dir = split "-1,1,1,-1",

  jd = nil,
  pwr = nil,

  init = function(_ENV)
    while not jd:cfree(sc) do
      sc = sc % #COLORS + 7
    end
  end,

  update = function(_ENV)
    local p = jd:active()

    if p.cpu then
      local tts = get_targets(p, jd)
      if #tts == 0 then
        return _ENV:move(jd:move_color(rndcolor(), rndcolor))
      end

      local bot = ai[p.cpu]
      _ENV:move(bot(tts, jd.f.t))
    else
      local btn = getbtn(jd.act - 1)
      if btn < 0 then
        return
      end
      if btn < 4 then
        local d = dir[btn + 1]
        sc = jd:move_color(sc, function(c)
          return (c + d - 1) % #COLORS + 7
        end, p.w)
        beep()
      else
        sfx(63)
        _ENV:move(sc)
      end
    end
  end,

  draw = function(_ENV)
    local p = jd:active()

    for idx, c in ipairs(COLORS) do
      local s = idx * 8 - 8

      if c == sc then
        rectfill(s, 120, s + 6, 126, c)
      elseif jd:cfree(c, p.w) then
        rectfill(s + 1, 121, s + 5, 125, c)
      else
        rect(s + 1, 121, s + 5, 125, c)
      end
    end
    local w, active = 51, jd.act
    for p in all(jd.players) do
      local n, c, t = p.n, p.c, tostr(#p.t)
      w = print((n == active and inv or "") .. pspace(t, 3) .. t, w + 5, 121, c)
    end
  end,

  move = function(_ENV, c)
    local next = jd:move(c)

    if pwr then
      pwr:register(c)
    end

    frz:freeze(5 + flr(rnd(10)))
    sc = jd:finish(next)
  end,
}

function get_targets(p, jd)
  local r, seen, t = {}, {}, jd.f.t
  for tn in all(p.t) do
    for fn in all(t[tn].hvrel) do
      local ft = t[fn]
      if ft.p == 0 then
        if not seen[fn] then
          seen[fn] = true
          if jd:cfree(ft.c) then
            add(r, fn)
          end
        end
      end
    end
  end
  return r
end

function get_clusters(targets, tiles)
  local seen, clusters = {}, { {}, {}, {}, {}, {}, {} }
  for tn in all(targets) do
    local cl = cluster(tn, tiles)
    local cnum = cl[1]
    if not seen[cnum] then
      seen[cnum] = true
      local t = tiles[tn]
      for cn in all(cl) do
        add(clusters[t.c - 6], cn)
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

-- random bot
function bot1(tts, t)
  return t[rnd(tts)].c
end

-- greedy bot (selects the target with biggest cluster)
function bot2(tts, t)
  return t[get_clusters(tts, t)[1][1]].c
end

ai = { bot1, bot2 }
