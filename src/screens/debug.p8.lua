function show_debug()
  cls()
  music(-1)
  local mode, mission = 1, dget(CDATA.mission)
  local toggle, sep =
    {
      name = "toggle mode: 1",
      callback = function(self, dir)
        mode = (mode - 1 + dir) % 5 + 1
        self.name = "toggle mode: " .. mode
      end,
    }, {
      name = "----------------",
      disabled = true,
      c = 1,
    }

  local ms = Menu:new({ offset = 0 }, {
    toggle,
    sep,
    {
      name = "screen - start",
      callback = show_start,
    },
    {
      name = "screen - brief " .. mission + 1,
      callback = function()
        local mission = dget(CDATA.mission)
        show_brief(mission + 1)
      end,
    },
    {
      name = "screen - mission " .. mission,
      callback = function()
        local mission = dget(CDATA.mission)
        if mission == 0 then
          show_mission(0, 2, 6, 20)
        end
        show_mission(mission)
      end,
    },
    {
      name = "screen - results " .. mission,
      callback = function()
        local mission, players = dget(CDATA.mission), {}
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

  local mc = Menu:new({
    offset = 0,
  }, {
    toggle,
    sep,
    {
      name = "campaign - mission: " .. dget(CDATA.mission),
      callback = function(self, dir)
        dset(CDATA.mission, (dget(CDATA.mission) - 1 + dir) % #MISSIONS + 1)
        self.name = "campaign - mission: " .. dget(CDATA.mission)
        ms.options[4].name = "screen - brief " .. dget(CDATA.mission) + 1
        ms.options[5].name = "screen - mission " .. dget(CDATA.mission)
        ms.options[6].name = "screen - results " .. dget(CDATA.mission)
      end,
    },
    {
      name = "campaign - place: " .. dget(CDATA.place),
      callback = function(self, dir)
        dset(CDATA.place, (dget(CDATA.place) - 1 + dir) % 4 + 1)
        self.name = "campaign - place: " .. dget(CDATA.place)
      end,
    },
    {
      name = "campaign - score: " .. dget(CDATA.score),
      callback = function(self, dir)
        dset(CDATA.score, dget(CDATA.score) + dir)
        self.name = "campaign - score: " .. dget(CDATA.score)
      end,
    },
    {
      name = "campaign - time: " .. dget(CDATA.time),
      callback = function(self, dir)
        dset(CDATA.time, dget(CDATA.time) + dir)
        self.name = "campaign - time: " .. dget(CDATA.time)
      end,
    },
    {
      name = "campaign - done: " .. dget(CDATA.done),
      callback = function(self, dir)
        dset(CDATA.done, (dget(CDATA.done) + dir) % 2)
        self.name = "campaign - done: " .. dget(CDATA.done)
      end,
    },
    sep,
    {
      name = "option - palette: " .. dget(CDATA.palette),
      callback = function(self, dir)
        dset(CDATA.palette, (dget(CDATA.palette) + dir) % 2)
        self.name = "option - palette: " .. dget(CDATA.palette)
      end,
    },
    {
      name = "option - mute: " .. dget(CDATA.mute),
      callback = function(self, dir)
        dset(CDATA.mute, (dget(CDATA.mute) + dir) % 2)
        self.name = "option - mute: " .. dget(CDATA.mute)
      end,
    },
    sep,
    {
      name = "unlock - arena: " .. dget(CDATA.arena),
      callback = function(self, dir)
        dset(CDATA.arena, (dget(CDATA.arena) - 1 + dir) % #ARENAS + 1)
        self.name = "unlock - arena: " .. dget(CDATA.arena)
      end,
    },
    {
      name = "unlock - practice: " .. dget(CDATA.practice),
      callback = function(self, dir)
        dset(CDATA.practice, (dget(CDATA.practice) + dir) % 2)
        self.name = "unlock - practice: " .. dget(CDATA.practice)
      end,
    },
  })

  local mmopts = { toggle, sep }
  for idx = 1, #MISSIONS do
    add(mmopts, {
      name = "score - m" .. idx .. ": " .. dget(CDATA.mscores + idx - 1),
      callback = function(self, dir)
        dset(CDATA.mscores + idx - 1, dget(CDATA.mscores + idx - 1) + dir)
        self.name = "score - m" .. idx .. ": " .. dget(CDATA.mscores + idx - 1)
      end,
    })
  end
  local mm = Menu:new({ offset = 0 }, mmopts)

  local maopts = { toggle, sep }
  for idx = 1, #ARENAS do
    add(maopts, {
      name = "score - a" .. idx .. ": " .. dget(CDATA.ascores + idx - 1),
      callback = function(self, dir)
        dset(CDATA.ascores + idx - 1, dget(CDATA.ascores + idx - 1) + dir)
        self.name = "score - a" .. idx .. ": " .. dget(CDATA.ascores + idx - 1)
      end,
    })
  end
  local ma = Menu:new({ offset = 0 }, maopts)

  local power = dget(CDATA.power)
  local mp = Menu:new({ offset = 0 }, {
    toggle,
    sep,
    {
      name = "power - snow: " .. (power & 1),
      callback = function(self, dir)
        power = invert(power, 1)
        dset(CDATA.power, power)
        self.name = "power - snow: " .. (power & 1)
      end,
    },
    {
      name = "power - fire: " .. (power & 2),
      callback = function(self, dir)
        power = invert(power, 2)
        dset(CDATA.power, power)
        self.name = "power - fire: " .. (power & 2)
      end,
    },
    {
      name = "power - desert: " .. (power & 4),
      callback = function(self, dir)
        power = invert(power, 4)
        dset(CDATA.power, power)
        self.name = "power - desert: " .. (power & 4)
      end,
    },
    {
      name = "power - sun: " .. (power & 8),
      callback = function(self, dir)
        power = invert(power, 8)
        dset(CDATA.power, power)
        self.name = "power - sun: " .. (power & 8)
      end,
    },
    {
      name = "power - woods: " .. (power & 16),
      callback = function(self, dir)
        power = invert(power, 16)
        dset(CDATA.power, power)
        self.name = "power - woods: " .. (power & 16)
      end,
    },
    {
      name = "power - storm: " .. (power & 32),
      callback = function(self, dir)
        power = invert(power, 32)
        dset(CDATA.power, power)
        self.name = "power - storm: " .. (power & 32)
      end,
    },
  })

  local menus = { mc, mp, mm, ma, ms }

  scene = {
    art(cls),
    Entity:new {
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

function invert(var, b)
  if var & b == 0 then
    return var | b
  else
    return var & ~b
  end
end
