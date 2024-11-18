Judge = Ent:create {
  act = 1,
  moves = 0,

  a = 0,
  num = 0,
  human = 1,

  plc = "22,379,39,362",

  -- f = nil,
  -- pwr = nil,
  -- seed = nil,

  init = function(_ENV)
    moves, start = 0, time()
    local t = f.t

    players = {}

    local init_player = function(pn, cpu, w)
      add(players, {
        n = pn,
        w = w,
        t = {},
        cpu = cpu,
        skip = 0,
        score = 0,
        c = _ENV:move_color(rndcolor(), rndcolor),
        take = function(self, t, an)
          t.p = self.n
          if an then
            t:anim(COLORS[self.c])
          end
          t.c = self.c
          add(self.t, t.n)
        end,
      })
    end

    -- init players
    for pn = 1, human do
      init_player(pn, false, dget(CART.power))
    end

    -- init bots
    if cpu then
      for b in all(split(cpu)) do
        init_player(#players + 1, b, 63)
      end
    end

    -- placement
    local s, pos = f.s, split(plc)
    for p in all(players) do
      for n in all(split(pos[p.n], "/")) do
        local tt = t[n]
        for nn in all(tt.hvrel) do
          local nt = t[nn]
          while nt:free() and nt.c == p.c do
            nt.c = rndcolor()
          end
        end
        p:take(tt)
      end
    end

    local pt = players[1].t[1]
    for n in all(t[pt].hvrel) do
      local tt = t[n]
      if tt:free() then
        t[n].c = _ENV:move_color(t[n].c, rndcolor)
      end
    end
  end,

  cfree = function(_ENV, c, w)
    for p in all(players) do
      if p.c == c then
        return false
      end
    end
    if w and pwr and pwr:active(c) then
      return w & (1 << (c - 1)) > 0
    end
    return true
  end,

  move_color = function(self, c, fn, w)
    repeat
      c = fn(c)
    until self:cfree(c, w)
    return c
  end,

  active = function(_ENV)
    return players[act]
  end,

  move = function(_ENV, c)
    local p = players[act]
    local tiles, ptiles, pwr = f.t, p.t, pwr and pwr:active(c)
    local npt, bombs = #ptiles, {}

    p.c = c
    moves += 1

    -- make a move
    foreach(ptiles, function(tn)
      local pt = tiles[tn]
      pt.c = c
      grab(pt.hvrel, tiles, p)
      if pwr then
        grab(pt.diag, tiles, p)
      end

      -- portals
      if pt.tp == 3 then
        foreach(tiles, function(t)
          if t.tp == 3 and t:free(c) then
            p:take(t)
          end
        end)

      -- bombs
      elseif pt.tp == 4 then
        add(bombs, tn)
      end
    end)

    local empty = #ptiles == npt
    p.skip = empty and p.skip + 1 or 0
    if p.skip >= 8 then
      p.c = nil
      foreach(ptiles, function(tn)
        tiles[tn].c = nil
      end)
    end

    if #bombs > 0 then
      foreach(bombs, function(bn)
        local bt = tiles[bn]
        bt:boom()
        foreach(bt.hvrel, function(n)
          local t = tiles[n]
          t:boom()
          foreach(t.hvrel, function(nn)
            local nt = tiles[nn]
            nt:boom()
            foreach(nt.hvrel, function(nnn)
              tiles[nnn]:boom()
            end)
          end)
        end)
      end)
      for p in all(players) do
        p.t = filter(p.t, function(tn)
          return tiles[tn].p == p.n
        end)
      end
    end

    -- keep the current player
    if pwr and not empty then
      sfx(53)
      return false
    end

    sfx(52)
    return true
  end,

  next_move = function(_ENV, next)
    if next then
      repeat
        act = (act % #players) + 1
      until players[act].skip < 8
    end

    local p = players[act]

    return _ENV:move_color(p.c, function(c)
      return c % #COLORS + 1
    end, p.w)
  end,

  finish = function(_ENV, next)
    local active_players = #filter(players, function(p)
      return p.skip < 8
    end)
    if active_players > 0 then
      for t in all(f.t) do
        if t:free() then
          return _ENV:next_move(next)
        end
      end
    end

    -- sort players
    local res = sort(players, function(a, b)
      return #a.t > #b.t
    end)

    -- calculate scores
    for pn, p in ipairs(res) do
      p.score = min(f.s * (#res - pn + 1), #p.t)
      for sn = pn + 1, #res do
        local sp = res[sn]
        p.score += #p.t - #sp.t
      end
    end

    -- play finish sound
    sfx(res[1].cpu and 55 or 54)

    pause(function()
      frz:freeze(60, Fade:new {}, function()
        results(res, moves, time() - start, num == 0 and a or num, num == 0 and "a" or "m", seed)
      end)
    end)
  end,
}

function grab(nts, ts, p)
  for nn in all(nts) do
    local nt = ts[nn]
    if nt:free(p.c) then
      p:take(nt, true)
    end
  end
end
