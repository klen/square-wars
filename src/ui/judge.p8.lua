Judge = Ent:create {
  act = 1,
  moves = 0,

  a = 0,
  num = 0,
  human = 1,
  plc = nil,

  -- @param pwr Power
  pwr = nil,
  -- @param f Field
  f = nil,

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
    for p in all(players) do
      local pos = positions(f.s, plc)
      for n in all(pos[p.n]) do
        local tt = t[n]
        for nn in all(tt.hvrel) do
          local nt = t[nn]
          while nt.c == p.c do
            nt.c = rndcolor()
          end
        end
        tt.p = p.n
        add(p.t, n)
      end
      for tt in all(p.t) do
        t[tt].c = p.c
      end
    end
  end,

  cfree = function(_ENV, c, w)
    for p in all(players) do
      if p.c == c then
        return false
      end
    end
    local idx = c - 6
    if w and pwr and pwr:active(c) then
      return w & (1 << (c - 7)) > 0
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
    local grab = #ptiles

    p.c = c
    moves += 1

    -- make a move
    foreach(ptiles, function(tn)
      local t = tiles[tn]
      t.c = c
      for nn in all(t.hvrel) do
        local n = tiles[nn]
        if n.p == 0 and n.c == c then
          n.p = act
          add(ptiles, nn)
        end
      end
      -- grab diag
      if pwr then
        for nn in all(t.diag) do
          local n = tiles[nn]
          if n.c == c and n.p == 0 then
            n.p = act
            add(ptiles, nn)
          end
        end
      end
    end)

    local empty = #ptiles == grab
    p.skip = empty and p.skip + 1 or 0
    if p.skip >= 8 then
      p.c = 5
      foreach(ptiles, function(tn)
        tiles[tn].c = 5
      end)
    end

    -- keep the current player
    if pwr and not empty then
      sfx(59)
      return false
    end

    if p.cpu then
      sfx(62)
    end
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
      return COLORS[c % #COLORS + 1]
    end, p.w)
  end,

  finish = function(_ENV, next)
    local active_players = #filter(players, function(p)
      return p.skip < 8
    end)
    if active_players > 0 then
      f:move()
      for t in all(f.t) do
        if t.p == 0 then
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
    printh(res[1].cpu and 60 or 61)
    sfx(res[1].cpu and 60 or 61)

    frz:freeze(40, Fade:new {}, function()
      results(res, moves, time() - start, num == 0 and a or num, num == 0 and "a" or "m")
    end)
  end,
}

function positions(s, plc)
  if not plc then
    return { { 1 }, { s * s }, { s }, { s * s - s + 1 } }
  end

  for k, v in pairs(plc) do
    plc[k] = split(v)
  end

  return plc
end
