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
      elseif jd:cfree(sc, p.w) then
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
    local p = jd:active()
    local score = #p.t
    local next = jd:move(c)

    if pwr then
      pwr:move(c)
    end

    add(frz.es, cnt(p, score, #p.t))
    frz:freeze(20, nil, function()
      sc = jd:finish(next)
    end)
    log("ctr: move " .. c .. " sc " .. sc)
  end,
}

function get_targets(p, jd)
  local r, seen, t = {}, {}, jd.f.t
  for tn in all(p.t) do
    for fn in all(t[tn].hvrel) do
      if not seen[fn] then
        seen[fn] = true
        local ft = t[fn]
        if ft:free() and jd:cfree(ft.c) then
          add(r, fn)
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

function cnt(p, sp, sn)
  local spd = (sn - sp) / 20
  return {
    update = function()
      sp += spd
    end,
    draw = function()
      local t, x = tostr(flr(sp)), 65 + 17 * (p.n - 1)
      rectfill(x - 1, 120, x + 12, 126, 0)
      print(inv .. pspace(t, 3) .. t, x, 121, COLORS[p.c])
    end,
  }
end
