Judge = Entity:create {
  active = 1,
  moves = 0,
  finished = false,

  arena = 0,
  mission = 0,
  human = 1,
  bots = nil,
  powers = 63,

  -- @param power Power
  power = nil,
  -- @param field Field
  field = nil,

  init = function(_ENV)
    moves, start = 0, time()
    local size = field.size
    local self, pos = _ENV, { 1, size * size, size, (size * size) - size + 1 }
    players, tiles = {}, field.tiles

    local init_player = function(pn, cpu, w)
      local pt = tiles[pos[pn]]
      pt.p = pn
      pt.c = self:move_color(rndcolor(), rndcolor)
      add(players, {
        n = pn,
        s = 0,
        w = w,
        c = pt.c,
        t = { pt },
        cpu = cpu,
      })
    end

    -- init players
    for pn = 1, human do
      init_player(pn, false, powers)
    end

    for b in all(bots) do
      init_player(#players + 1, b, 63)
    end

    -- fix positions
    for p in all(pos) do
      local pt = tiles[p]
      for t in all(pt:free()) do
        t.c = self:move_color(t.c, rndcolor)
      end
    end
  end,

  update = function(_ENV)
    for t in all(tiles) do
      if t.p == 0 then
        return
      end
    end

    finished = true

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
            dset(cdata.place, place)
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
    local tiles, pwr = p.t, power and power.levels[c] == 3

    p.c = c
    moves += 1

    -- make a move
    foreach(tiles, function(t)
      t.c = c
      for n in all(t:free()) do
        if n.c == c then
          n.p = active
          add(tiles, n)
        end
      end
      -- grab diag
      if pwr then
        for n in all(t.diag) do
          if n.c == c and n.p == 0 then
            n.p = active
            add(tiles, n)
          end
        end
      end
    end)

    -- make a power move
    if pwr then
      sfx(59)
    else
      if p.cpu then
        sfx(62)
      end
      active = (active % #players) + 1
    end
  end,
}
