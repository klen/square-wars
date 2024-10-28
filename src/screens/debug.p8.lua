function show_debug()
  cls()
  music(-1)

  local mode, mission = 1, dget(cdata.mission)
  local toggle, sep =
    {
      name = "toggle mode: 1",
      callback = function(self, dir)
        mode = (mode - 1 + dir) % 4 + 1
        self.name = "toggle mode: " .. mode
      end,
    }, {
      name = "----------------",
      disabled = true,
      c = 1,
    }

  local m4 = menu:new({ offset = 0 }, {
    toggle,
    sep,
    {
      name = "screen - start",
      callback = show_start,
    },
    {
      name = "screen - brief " .. mission,
      callback = function()
        local mission = dget(cdata.mission)
        show_brief(mission)
      end,
    },
    {
      name = "screen - mission " .. mission,
      callback = function()
        local mission = dget(cdata.mission)
        if mission == 0 then
          show_mission(0, 2, 6, 20)
        end
        show_mission(mission)
      end,
    },
    {
      name = "screen - results " .. mission,
      callback = function()
        local mission, players = dget(cdata.mission), {}
        for idx = 1, 2 + flr(rnd(3)) do
          add(players, {
            n = idx,
            s = flr(rnd(100)),
            cpu = flr(rnd(2)) == 1,
          })
          sort(players, function(a, b)
            return a.s > b.s
          end)
        end
        show_results(
          players,
          flr(rnd(100)),
          flr(rnd(100)),
          mission ~= 0 and mission or 1,
          mission ~= 0 and "m" or "a"
        )
      end,
    },
    {
      name = "screen - gameover",
      callback = show_gameover,
    },
    {
      name = "screen - practice",
      callback = show_practice,
    },
    {
      name = "screen - scores",
      callback = show_scores,
    },
  })

  local m1 = menu:new({
    offset = 0,
  }, {
    toggle,
    sep,
    {
      name = "campaign - mission: " .. dget(cdata.mission),
      callback = function(self, dir)
        dset(cdata.mission, (dget(cdata.mission) - 1 + dir) % #missions + 1)
        self.name = "campaign - mission: " .. dget(cdata.mission)
        m4.options[4].name = "screen - brief " .. dget(cdata.mission)
        m4.options[5].name = "screen - mission " .. dget(cdata.mission)
        m4.options[6].name = "screen - results " .. dget(cdata.mission)
      end,
    },
    {
      name = "campaign - place: " .. dget(cdata.place),
      callback = function(self, dir)
        dset(cdata.place, (dget(cdata.place) - 1 + dir) % 4 + 1)
        self.name = "campaign - place: " .. dget(cdata.place)
      end,
    },
    {
      name = "campaign - score: " .. dget(cdata.score),
      callback = function(self, dir)
        dset(cdata.score, dget(cdata.score) + dir)
        self.name = "campaign - score: " .. dget(cdata.score)
      end,
    },
    {
      name = "campaign - time: " .. dget(cdata.time),
      callback = function(self, dir)
        dset(cdata.time, dget(cdata.time) + dir)
        self.name = "campaign - time: " .. dget(cdata.time)
      end,
    },
    {
      name = "campaign - done: " .. dget(cdata.done),
      callback = function(self, dir)
        dset(cdata.done, (dget(cdata.done) + dir) % 2)
        self.name = "campaign - done: " .. dget(cdata.done)
      end,
    },
    sep,
    {
      name = "option - palette: " .. dget(cdata.palette),
      callback = function(self, dir)
        dset(cdata.palette, (dget(cdata.palette) + dir) % 2)
        self.name = "option - palette: " .. dget(cdata.palette)
      end,
    },
    {
      name = "option - mute: " .. dget(cdata.mute),
      callback = function(self, dir)
        dset(cdata.mute, (dget(cdata.mute) + dir) % 2)
        self.name = "option - mute: " .. dget(cdata.mute)
      end,
    },
    sep,
    {
      name = "unlock - arena: " .. dget(cdata.arena),
      callback = function(self, dir)
        dset(cdata.arena, (dget(cdata.arena) - 1 + dir) % #arenas + 1)
        self.name = "unlock - arena: " .. dget(cdata.arena)
      end,
    },
    {
      name = "unlock - practice: " .. dget(cdata.practice),
      callback = function(self, dir)
        dset(cdata.practice, (dget(cdata.practice) + dir) % 2)
        self.name = "unlock - practice: " .. dget(cdata.practice)
      end,
    },
  })

  local m2opts = { toggle, sep }
  for idx = 1, #missions do
    add(m2opts, {
      name = "score - m" .. idx .. ": " .. dget(cdata.mscores + idx - 1),
      callback = function(self, dir)
        dset(cdata.mscores + idx - 1, dget(cdata.mscores + idx - 1) + dir)
        self.name = "score - m" .. idx .. ": " .. dget(cdata.mscores + idx - 1)
      end,
    })
  end
  local m2 = menu:new({ offset = 0 }, m2opts)

  local m3opts = { toggle, sep }
  for idx = 1, #arenas do
    add(m3opts, {
      name = "score - a" .. idx .. ": " .. dget(cdata.ascores + idx - 1),
      callback = function(self, dir)
        dset(cdata.ascores + idx - 1, dget(cdata.ascores + idx - 1) + dir)
        self.name = "score - a" .. idx .. ": " .. dget(cdata.ascores + idx - 1)
      end,
    })
  end
  local m3 = menu:new({ offset = 0 }, m3opts)

  local menus = { m1, m2, m3, m4 }

  scene = {
    art(cls),
    entity:new {
      update = function()
        local m = menus[mode]
        m:update()
      end,
      draw = function()
        local m = menus[mode]
        m:draw()
      end,
    },
  }
end

menuitem(3, "debug", show_debug)
