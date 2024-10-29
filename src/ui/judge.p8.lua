judge = entity:create {
  moves = 0,
  arena = 0,
  active = 1,
  mission = 0,
  human = 1,
  bots = nil,
  finished = false,

  init = function(_ENV)
    moves, start = 0, time()
    local size = field.size
    local self, pos = _ENV, { 1, size * size, size, (size * size) - size + 1 }
    players, tiles = {}, field.tiles

    local init_player = function(pn, cpu)
      printh("init player " .. pn .. " cpu " .. tostr(cpu))
      local pt = tiles[pos[pn]]
      pt.p = pn
      pt.c = self:move_color(rndcolor(), rndcolor)
      add(players, {
        n = pn,
        s = 0,
        c = pt.c,
        t = { pt },
        cpu = cpu,
      })
    end

    -- init players
    for pn = 1, human do
      init_player(pn, false)
    end

    for b in all(bots) do
      init_player(#players + 1, b)
    end

    printh("--- players " .. #players)
    for p in all(players) do
      printh("player " .. p.n .. " cpu " .. (p.cpu and p.cpu or "-"))
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
      fade:new {
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
  color_available = function(self, c)
    for p in all(self.players) do
      if p.c == c then
        return false
      end
    end
    return true
  end,
  move_color = function(self, c, fn)
    repeat
      c = fn(c)
    until self:color_available(c)
    return c
  end,
  get_active = function(_ENV)
    return players[active]
  end,
  move = function(_ENV, c)
    local p = players[active]
    p.c = c
    foreach(p.t, function(t)
      t.c = c
      grab_near(p, t)
    end)
    moves = moves + 1
    active = (active % #players) + 1
    if p.cpu then
      sfx(62)
    end
  end,
}

function grab_near(p, pt)
  for n in all(pt:free()) do
    if n.c == pt.c then
      n.p = p.n
      add(p.t, n)
      grab_near(p, n)
    end
  end
end
