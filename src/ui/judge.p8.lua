judge = entity:create {
  moves = 0,
  arena = 0,
  active = 1,
  mission = 0,
  num_players = 2,
  finished = false,

  init = function(_ENV)
    moves, start = 0, time()
    local size = field.size
    local self, pos = _ENV, { 1, size * size, size, (size * size) - size + 1 }
    players, tiles = {}, field.tiles

    -- init players
    for pn = 1, num_players do
      local pt = tiles[pos[pn]]
      pt.p = pn
      pt.c = self:move_color(rndcolor(), rndcolor)
      add(players, {
        n = pn,
        c = pt.c,
        t = { pt },
        cpu = pn ~= 1,
      })
    end

    -- fix positions
    for p in all(pos) do
      local pt = tiles[p]
      for t in all(field:get_neighbours(pt)) do
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

    local player = players[1]
    sort(players, function(a, b)
      return #a.t > #b.t
    end)
    local seconds, place = time() - start, find(players, player)
    local score = 0
    for n = place + 1, #players do
      score += #player.t - #players[n].t
    end

    sfx(place == 1 and 61 or 60)

    freeze_update(
      71,
      fade:new {
        frames = 70,
        callback = function()
          if mission ~= 0 then
            dset(cdata.place, place)
          end
          show_results(
            mission == 0 and arena or mission,
            place,
            score,
            moves,
            seconds,
            mission ~= 0
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
    sfx(1)
    local p = players[active]
    p.c = c
    foreach(p.t, function(t)
      t.c = c
      grab_near(p, t, field)
    end)
    moves = moves + 1
    active = (active % #players) + 1
  end,
}

function grab_near(p, pt, field)
  for n in all(field:get_neighbours(pt)) do
    if n.c == pt.c then
      n.p = p.n
      add(p.t, n)
      grab_near(p, n, field)
    end
  end
end
