-- globals: colors
--
Ctrl = Ent:create {
  sc = 7,
  dir = split "-1,1,1,-1",

  jd = nil,
  pwr = nil,

  init = function(_ENV)
    while not jd:cfree(sc) do
      sc = sc % #COLORS + 1
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
          return (c + d - 1) % #COLORS + 1
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

    for c = 1, #COLORS do
      local s, cl = c * 8 - 8, COLORS[c]
      if c == sc then
        rectfill(s, 120, s + 6, 126, cl)
      elseif jd:cfree(c, p.w) then
        rectfill(s + 1, 121, s + 5, 125, cl)
      else
        rect(s + 1, 121, s + 5, 125, cl)
      end
      local w, active = 60, jd.act
      for p in all(jd.players) do
        local n, c, t = p.n, p.c, tostr(#p.t)
        w = print((n == active and inv or "") .. pspace(t, 3) .. t, w + 5, 121, COLORS[p.c] or 1)
      end
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
      if not ft.p then
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

-- random bot
function bot1(tts, t)
  return t[rnd(tts)].c
end

-- greedy bot (selects the target with biggest cluster)
function bot2(tts, t)
  return t[get_clusters(tts, t)[1][1]].c
end

ai = { bot1, bot2 }
