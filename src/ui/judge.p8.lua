Judge = Entity:create {
  active = 1,
  moves = 0,

  plc = 1,
  arena = 0,
  mission = 0,
  human = 1,
  bots = nil,
  powers = 63,

  -- @param power Power
  power = nil,
  -- @param field Field
  field = nil,

  positions = function(size, plc)
    if plc == 2 then
      return { { 1, size * size - size + 1 }, { size, size * size } }
    elseif plc == 3 then
      return { { 169 }, { 172 }, { 229 }, { 232 } }
    elseif plc == 4 then
      return { { 85 }, { 96 }, { 305 }, { 316 } }
    end
    return { { 1 }, { size * size }, { size }, { size * size - size + 1 } }
  end,

  init = function(_ENV)
    moves, start = 0, time()
    local size, tiles = field.size, field.tiles

    players = {}

    local init_player = function(pn, cpu, w)
      add(players, {
        n = pn,
        s = 0,
        w = w,
        cpu = cpu,
        t = {},
        c = _ENV:move_color(rndcolor(), rndcolor),
      })
    end

    -- init players
    for pn = 1, human do
      init_player(pn, false, powers)
    end

    for b in all(bots) do
      init_player(#players + 1, b, 63)
    end

    -- placement
    for p in all(players) do
      local pos = _ENV.positions(size, _ENV.plc)
      for n in all(pos[p.n]) do
        local t = tiles[n]
        for nn in all(t.hvrel) do
          local nt = tiles[nn]
          while nt.c == p.c do
            nt.c = rndcolor()
          end
        end
        t.c = p.c
        t.p = p.n
        add(p.t, n)
      end
    end
  end,

  finish = function(_ENV)
    for t in all(field.tiles) do
      if t.p == 0 then
        return
      end
    end

    -- sort places
    local res = sort(players, function(a, b)
      return #a.t > #b.t
    end)

    -- calculate scores
    for pn = 1, #res do
      local p = res[pn]
      for sn = pn + 1, #res do
        local sp = res[sn]
        if p.cpu or sp.cpu then
          p.s += #p.t - #sp.t
        end
      end
    end

    sfx(res[1].cpu and 60 or 61)

    freeze_update(
      71,
      Fade:new {
        frames = 70,
        callback = function()
          if mission ~= 0 then
            dset(CDATA.place, place)
          end
          show_results(
            res,
            moves,
            time() - start,
            mission == 0 and arena or mission, -- mission or arena number
            mission == 0 and "a" or "m" -- mode
          )
        end,
      }
    )
  end,

  color_available = function(_ENV, c, w)
    for p in all(players) do
      if p.c == c then
        return false
      end
    end
    if w and power and power:active(c) then
      return 2 ^ (c - 1) & w > 0
    end
    return true
  end,

  move_color = function(self, c, fn, w)
    repeat
      c = fn(c)
    until self:color_available(c, w)
    return c
  end,

  get_active = function(_ENV)
    return players[active]
  end,

  move = function(_ENV, c)
    local p = players[active]
    local tiles, ptiles, pwr = field.tiles, p.t, power and power:active(c)
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
          n.p = active
          add(ptiles, nn)
        end
      end
      -- grab diag
      if pwr then
        for nn in all(t.diag) do
          local n = tiles[nn]
          if n.c == c and n.p == 0 then
            n.p = active
            add(ptiles, nn)
          end
        end
      end
    end)

    -- make a power move
    if pwr and #ptiles > grab then
      sfx(59)
    else
      if p.cpu then
        sfx(62)
      end
      active = (active % #players) + 1
    end
  end,
}
